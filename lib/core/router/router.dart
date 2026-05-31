import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kenryo_tankyu/features/auth/presentation/providers/auth_provider.dart';
import 'package:kenryo_tankyu/core/providers/deep_link_provider.dart';

// Auth
import 'package:kenryo_tankyu/features/auth/presentation/screens/welcome_page.dart';
import 'package:kenryo_tankyu/features/auth/presentation/screens/create_password_page.dart';
import 'package:kenryo_tankyu/features/auth/presentation/screens/verify_name_page.dart';
import 'package:kenryo_tankyu/features/auth/presentation/screens/login_page.dart';
import 'package:kenryo_tankyu/features/auth/presentation/screens/reset_password_page.dart';
import 'package:kenryo_tankyu/features/auth/presentation/screens/verify_email_page.dart';

// Search
import 'package:kenryo_tankyu/features/search/presentation/screens/category_select_page.dart';
import 'package:kenryo_tankyu/features/search/presentation/screens/result_list_page.dart';
import 'package:kenryo_tankyu/features/search/presentation/screens/search_page.dart';
import 'package:kenryo_tankyu/features/search/presentation/screens/sub_category_select_page.dart';

// Features
import 'package:kenryo_tankyu/features/notification/presentation/screens/notification_page.dart';
import 'package:kenryo_tankyu/features/research_work/presentation/screens/result_page.dart';
import 'package:kenryo_tankyu/features/settings/presentation/screens/settings_page.dart';
import 'package:kenryo_tankyu/features/teacher/presentation/screens/show_teacher_pdf.dart';
import 'package:kenryo_tankyu/features/teacher/presentation/screens/teacher_select_page.dart';

// Shell (BottomNavigationBar)
import 'package:kenryo_tankyu/presentation/screens/home_page.dart';
import 'package:kenryo_tankyu/presentation/screens/explore_page.dart';
import 'package:kenryo_tankyu/presentation/screens/library_page.dart';
import 'package:kenryo_tankyu/presentation/widget/widget.dart';

// Dev / Test
import 'package:kenryo_tankyu/test/test_file_select.dart';
import 'package:kenryo_tankyu/test/test_for_aoi.dart';
import 'package:kenryo_tankyu/test/test_for_coji.dart';
import 'package:kenryo_tankyu/test/test_for_mitsuki.dart';

final navigationKey = GlobalKey<NavigatorState>();

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

final routesProvider = Provider<GoRouter>((ref) {
  final router = GoRouter(
    initialLocation: '/welcome',
    navigatorKey: _rootNavigatorKey,
    redirect: (context, state) {
      final authAsync = ref.read(authStateChangesProvider);
      if (!authAsync.hasValue) return null;
      final user = authAsync.value;

      final loc = state.matchedLocation;
      final isOnWelcome = loc.startsWith('/welcome');
      final isOnVerifyEmail = loc == '/verify_email';

      if (user == null) {
        // ディープリンクで未ログイン時: 元のパスを保存してwelcomeへ
        if (!isOnWelcome) {
          ref.read(deepLinkPathProvider.notifier).state = loc;
          return '/welcome';
        }
        return null;
      }
      if (!user.emailVerified) {
        return isOnVerifyEmail ? null : '/verify_email';
      }
      // ログイン完了後: 保存したディープリンク先があればそこへ
      if (isOnWelcome || isOnVerifyEmail) {
        final pending = ref.read(deepLinkPathProvider);
        if (pending != null) {
          ref.read(deepLinkPathProvider.notifier).state = null;
          return pending;
        }
        return '/home';
      }
      return null;
    },
    routes: [
      // ─── 認証フロー ───────────────────────────────────────────
      GoRoute(
        path: '/welcome',
        builder: (context, state) => const WelcomePage(),
        routes: [
          GoRoute(
            path: 'verify_name',
            builder: (context, state) => const VerifyNamePage(),
            routes: [
              GoRoute(
                path: 'create_password',
                builder: (context, state) => const CreatePassWordPage(),
              ),
            ],
          ),
          GoRoute(
            path: 'login',
            builder: (context, state) =>
                LoginPage(isDeveloper: state.extra as bool? ?? false),
            routes: [
              GoRoute(
                path: 'reset_password',
                builder: (context, state) => const ResetPasswordPage(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/verify_email',
        builder: (context, state) => const CheckEmailPage(),
      ),

      // ─── 検索フロー ───────────────────────────────────────────
      // 遷移順: /search → /categorySelect → /subCategory → /resultList
      //         /search → /subCategory → /resultList
      //         /explore(shell) → /subCategory → /resultList
      GoRoute(
        path: '/search',
        builder: (context, state) => const SearchPage(),
      ),
      GoRoute(
        path: '/categorySelect',
        builder: (context, state) => const CategorySelectPage(),
      ),
      GoRoute(
        path: '/subCategory',
        builder: (context, state) => const SubCategorySelectPage(),
      ),
      GoRoute(
        path: '/resultList',
        builder: (context, state) => ResultListPage(),
      ),

      // ─── 作品詳細 ─────────────────────────────────────────────
      GoRoute(
        path: '/result/:documentID',
        builder: (context, state) {
          final documentID = state.pathParameters['documentID']!;
          return ResultPage(documentID: int.parse(documentID));
        },
      ),

      // ─── その他の機能 ─────────────────────────────────────────
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsPage(),
      ),
      GoRoute(
        path: '/notifications',
        builder: (context, state) => const NotificationPage(),
      ),
      GoRoute(
        path: '/teacher',
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: TeacherSelectPage()),
        routes: [
          GoRoute(
            path: 'showPdf',
            builder: (context, state) => const ShowTeacherPdfPage(),
          ),
        ],
      ),

      // ─── BottomNavigationBar (ShellRoute) ────────────────────
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => Footer(child: child),
        routes: [
          GoRoute(
            path: '/home',
            pageBuilder: (context, state) =>
                NoTransitionPage(child: HomePage(key: state.pageKey)),
          ),
          GoRoute(
            path: '/explore',
            pageBuilder: (context, state) =>
                NoTransitionPage(child: ExplorePage(key: state.pageKey)),
          ),
          GoRoute(
            path: '/library',
            pageBuilder: (context, state) =>
                NoTransitionPage(child: LibraryPage(key: state.pageKey)),
          ),

          // ─── 開発用テスト画面 ────────────────────────────────
          GoRoute(
            path: '/testSelect',
            pageBuilder: (context, state) =>
                NoTransitionPage(child: TestSelectPage(key: state.pageKey)),
            routes: [
              GoRoute(
                path: 'mitsuki',
                builder: (context, state) => const TestForMitsuki(),
              ),
              GoRoute(
                path: 'coji',
                builder: (context, state) => const TestForCoji(),
              ),
              GoRoute(
                path: 'aoi',
                builder: (context, state) => const TestForAoi(),
              ),
            ],
          ),
        ],
      ),
    ],
    errorPageBuilder: (context, state) => MaterialPage(
      key: state.pageKey,
      child: Scaffold(body: Center(child: Text(state.error.toString()))),
    ),
  );

  ref.listen(authStateChangesProvider, (_, __) => router.refresh());
  return router;
});
