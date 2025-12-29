import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kenryo_tankyu/features/auth/presentation/providers/auth_provider.dart';

import 'package:kenryo_tankyu/features/auth/presentation/screens/welcome_page.dart';
import 'package:kenryo_tankyu/features/auth/presentation/screens/create_password_page.dart';
import 'package:kenryo_tankyu/features/auth/presentation/screens/verify_name_page.dart';
import 'package:kenryo_tankyu/features/auth/presentation/screens/login_page.dart';
import 'package:kenryo_tankyu/features/auth/presentation/screens/reset_password_page.dart';
import 'package:kenryo_tankyu/features/auth/presentation/screens/verify_email_page.dart';
import 'package:kenryo_tankyu/features/krgp/presentation/screens/krgp_home_page.dart';
import 'package:kenryo_tankyu/features/krgp/presentation/screens/krgp_year_page.dart';
import 'package:kenryo_tankyu/features/notification/presentation/screens/notification_page.dart';
import 'package:kenryo_tankyu/features/research_work/presentation/screens/result_page.dart';
import 'package:kenryo_tankyu/features/search/presentation/screens/result_list_page.dart';
import 'package:kenryo_tankyu/features/search/presentation/screens/search_page.dart';
import 'package:kenryo_tankyu/features/search/presentation/screens/sub_category_select_page.dart';
import 'package:kenryo_tankyu/features/settings/presentation/screens/settings_page.dart';
import 'package:kenryo_tankyu/features/teacher/presentation/screens/show_teacher_pdf.dart';
import 'package:kenryo_tankyu/features/teacher/presentation/screens/teacher_select_page.dart';
import 'package:kenryo_tankyu/presentation/screens/home_page.dart';
import 'package:kenryo_tankyu/presentation/screens/explore_page.dart';
import 'package:kenryo_tankyu/presentation/screens/library_page.dart';
import 'package:kenryo_tankyu/presentation/widget/widget.dart';
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
  // 認証状態を監視してリダイレクト先を決定する
  final authStateAsync = ref.watch(authStateChangesProvider);
  final redirection = authStateAsync.hasValue
      ? authStateAsync.value == null
          ? '/welcome'
          : '/home'
      : '/welcome';

  return GoRouter(
    initialLocation: redirection,
    navigatorKey: _rootNavigatorKey,
    routes: [
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
                ]),
            GoRoute(
                path: 'login',
                builder: (context, state) =>
                    LoginPage(isDeveloper: state.extra as bool),
                routes: [
                  GoRoute(
                    path: 'reset_password',
                    builder: (context, state) => const ResetPasswordPage(),
                  )
                ]),
          ]),
      GoRoute(
        path: '/verify_email',
        builder: (context, state) => const CheckEmailPage(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsPage(),
      ),
      GoRoute(
        path: '/notifications',
        builder: (context, state) => const NotificationPage(),
      ),
      GoRoute(
        path: '/result/:documentID',
        builder: (context, state) {
          final documentID = state.pathParameters['documentID']!;
          return ResultPage(documentID: int.parse(documentID));
        },
      ),
      GoRoute(
        path: '/krgp',
        builder: (context, state) => const KrgpPage(),
        routes: [
          GoRoute(
            path: 'year',
            builder: (context, state) =>
                KrgpYearPage(year: state.extra as String),
          ),
        ],
      ),
      GoRoute(
          path: '/teacher',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: TeacherSelectPage()),
          routes: <RouteBase>[
            GoRoute(
              path: 'showPdf',
              builder: (context, state) => const ShowTeacherPdfPage(),
            ),
          ]),

      GoRoute(
        path: '/resultList',
        builder: (context, state) => ResultListPage(),
      ),
      GoRoute(
        path: '/subCategory',
        builder: (context, state) => const SubCategorySelectPage(),
      ),
      GoRoute(
        path: '/search',
        builder: (context, state) => const SearchPage(),
      ),

      //ShellRoute内にBottomNavigationBarで遷移する画面を記載する
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        //BottomNavigationBarを実装しているページを記載する
        //childでScaffoldのbodyを渡す
        builder: (context, state, child) => Footer(child: child),
        routes: <RouteBase>[
          //BottomNavigationBarから遷移するページを記載する
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
          GoRoute(
            path: '/testSelect',
            pageBuilder: (context, state) =>
                NoTransitionPage(child: TestSelectPage(key: state.pageKey)),
            routes: <RouteBase>[
              GoRoute(
                  path: 'mitsuki',
                  builder: (context, state) => const TestForMitsuki()),
              GoRoute(
                  path: 'coji',
                  builder: (context, state) => const TestForCoji()),
              GoRoute(
                  path: 'aoi', builder: (context, state) => const TestForAoi()),
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
});
