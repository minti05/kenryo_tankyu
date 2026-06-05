import 'dart:io';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenryo_tankyu/features/settings/presentation/providers/settings_providers.dart';
import 'package:kenryo_tankyu/firebase_options.dart';
import 'package:kenryo_tankyu/core/router/router.dart';
import 'package:kenryo_tankyu/core/theme/theme.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:kenryo_tankyu/core/providers/shared_preferences_provider.dart';
import 'package:kenryo_tankyu/core/services/firebase_tracking_service.dart';
import 'package:path/path.dart' as path;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 依存性の事前初期化 (Strict Initialization)
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Crashlytics / Analytics の初期化 (グローバルエラーハンドラーを含む)
  await FirebaseTrackingService.initialize();

  await dotenv.load(fileName: 'assets/.env');

  final supabaseUrl = dotenv.env['SUPABASE_URL'];
  final supabaseAnonKey = dotenv.env['SUPABASE_ANON_KEY'];
  if (supabaseUrl == null || supabaseAnonKey == null) {
    throw StateError(
      'assets/.env に SUPABASE_URL または SUPABASE_ANON_KEY が定義されていません。'
      'assets/.env.example を参考に assets/.env を作成してください。',
    );
  }

  await Supabase.initialize(
    url: supabaseUrl,
    publishableKey: supabaseAnonKey,
  );

  final sharedPreferences = await SharedPreferences.getInstance();

  final needsMigrationDialog = await _migrateLegacyDb(sharedPreferences);
  if (needsMigrationDialog) {
    await sharedPreferences.setBool(
        'supabase_migration_dialog_pending_v1', true);
  }

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: const MainApp(),
    ),
  );
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint('Handling a background message ${message.messageId}');
}

/// SQLite→Supabase移行後の旧DBファイルを削除する。
/// 旧ファイルが実際に存在して削除した場合のみ true を返す（ダイアログ表示フラグ）。
Future<bool> _migrateLegacyDb(SharedPreferences prefs) async {
  const key = 'supabase_migrated_v1';
  if (prefs.getBool(key) == true) return false;

  bool deletedAny = false;
  try {
    final dbDir = await getDatabasesPath();
    for (final name in ['searched_history.db', 'search_history.db']) {
      final file = File(path.join(dbDir, name));
      if (await file.exists()) {
        await file.delete();
        deletedAny = true;
      }
    }
    await prefs.setBool(key, true);
  } catch (e, stackTrace) {
    debugPrint('Failed to migrate legacy DB: $e');
    debugPrintStack(stackTrace: stackTrace);
  }
  return deletedAny;
}

class MainApp extends ConsumerStatefulWidget {
  const MainApp({super.key});

  @override
  ConsumerState<MainApp> createState() => _MainAppState();
}

class _MainAppState extends ConsumerState<MainApp> {
  @override
  void initState() {
    super.initState();

    // アプリがフォアグラウンドにあるときにメッセージを受信したときの処理
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('フォアグラウンドでメッセージを受信: ${message.notification?.title}');
    });

    // 通知をタップしてアプリがバックグラウンドから復帰したときの処理
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('通知をタップしてアプリを開いた: ${message.notification?.title}');
    });
  }

  @override
  Widget build(BuildContext context) {
    final routerConfig = ref.watch(routesProvider);
    final themeMode = ref.watch(themeModeProvider).when(
          data: (m) => m,
          loading: () => ThemeMode.system,
          error: (_, __) => ThemeMode.system,
        );
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      //幅と高さの最小値に応じてテキストサイズを可変させるか
      minTextAdapt: true,
      //split screenに対応するかどうか？
      splitScreenMode: true,
      child: DynamicColorBuilder(builder: (lightDynamic, darkDynamic) {
        ColorScheme lightColorScheme;
        ColorScheme darkColorScheme;

        if (lightDynamic != null && darkDynamic != null) {
          lightColorScheme = lightDynamic.harmonized();
          darkColorScheme = darkDynamic.harmonized();
        } else {
          lightColorScheme = MaterialTheme.lightScheme();
          darkColorScheme = MaterialTheme.darkScheme();
        }

        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: routerConfig,
          themeMode: themeMode,
          darkTheme:
              ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: lightColorScheme,
          ),
          builder: (context, child) => child!,
        );
      }),
    );
  }
}
