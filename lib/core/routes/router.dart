import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:padi/modules/app_scaffold.dart';
import 'package:padi/modules/attendance/record/attendance_record_page.dart';
import 'package:padi/modules/attendance/record/presenters/widgets/record_history_detail/record_history_detail_page.dart';
import 'package:padi/modules/attendance/schedule/attendance_schedule_page.dart';
import 'package:padi/modules/authentication/login/login_page.dart';
import 'package:padi/modules/authentication/recover_password/recover_password_page.dart';
import 'package:padi/modules/authentication/register/register_page.dart';
import 'package:padi/modules/dashboard/dashboard_page.dart';
import 'package:padi/modules/dashboard/presenters/widgets/notifications/notifications_page.dart';
import 'package:padi/modules/settings/presenters/widgets/application_help/app_help_page.dart';
import 'package:padi/modules/settings/presenters/widgets/application_info/app_info_page.dart';
import 'package:padi/modules/settings/presenters/widgets/application_log/app_log_page.dart';
import 'package:padi/modules/settings/presenters/widgets/notification_settings/notification_settings_page.dart';
import 'package:padi/modules/settings/presenters/widgets/profile_settings/profile_settings_page.dart';
import 'package:padi/modules/settings/settings_page.dart';
import 'package:padi/modules/splash/splash_screen.dart';


final GlobalKey<NavigatorState> _rootNavigator = GlobalKey();
final GlobalKey<NavigatorState> _shellNavigator = GlobalKey();

final GoRouter router = GoRouter(
    navigatorKey: _rootNavigator,
    initialLocation: '/splash',
    routes: <RouteBase>[
      GoRoute(
        path: '/splash',
        parentNavigatorKey: _rootNavigator,
        pageBuilder: (context, state) => NoTransitionPage(
          child: PadiSplashScreen(
            key: state.pageKey,
          )
        )
      ),
      GoRoute(
          path: '/login',
          parentNavigatorKey: _rootNavigator,
          pageBuilder: (context, state) => NoTransitionPage(
              child: LoginPage(
                key: state.pageKey,
              )
          )
      ),
      GoRoute(
          path: '/register',
          parentNavigatorKey: _rootNavigator,
          pageBuilder: (context, state) => NoTransitionPage(
              child: RegisterPage(
                key: state.pageKey,
              )
          )
      ),
      GoRoute(
          path: '/recover-password',
          parentNavigatorKey: _rootNavigator,
          pageBuilder: (context, state) => NoTransitionPage(
              child: RecoverPasswordPage(
                key: state.pageKey,
              )
          )
      ),
      ShellRoute(
          navigatorKey: _shellNavigator,
          builder: (context, state, child) {
            return AppScaffold(
              key: state.pageKey,
              child: child,
            );
          },
          routes: [
            GoRoute(
                path: '/dashboard',
                parentNavigatorKey: _shellNavigator,
                pageBuilder: (context, state) => NoTransitionPage(
                    child: DashboardPage(
                        key: state.pageKey
                    )
                )
            ),
            GoRoute(
                path: '/attendance-record',
                parentNavigatorKey: _shellNavigator,
                pageBuilder: (context, state) => NoTransitionPage(
                    child: AttendanceRecordPage(
                        key: state.pageKey
                    )
                )
            ),
            GoRoute(
                path: '/settings',
                parentNavigatorKey: _shellNavigator,
                pageBuilder: (context, state) => NoTransitionPage(
                    child: SettingsPage(
                        key: state.pageKey
                    )
                )
            ),
          ]
      ),
      GoRoute(
          path: '/notifications',
          parentNavigatorKey: _rootNavigator,
          pageBuilder: (context, state) => NoTransitionPage(
              child: NotificationsPage(
                key: state.pageKey,
              )
          )
      ),
      GoRoute(
          path: '/attendance-record-detail/:attendanceId',
          parentNavigatorKey: _rootNavigator,
          pageBuilder: (context, state) => NoTransitionPage(
              child: RecordHistoryDetailPage(
              key: state.pageKey,
              attendanceId: state.pathParameters['attendanceId']
              )
          )
      ),
      GoRoute(
          path: '/monthly-schedule',
          parentNavigatorKey: _rootNavigator,
          pageBuilder: (context, state) => NoTransitionPage(
              child: MonthlySchedulePage(
                key: state.pageKey,
              )
          )
      ),
      GoRoute(
        path: '/application-log',
        parentNavigatorKey: _rootNavigator,
        pageBuilder: (context, state) => NoTransitionPage(
          child: AppLogPage(
            key: state.pageKey,
          )
        )
      ),
      GoRoute(
          path: '/notification-settings',
          parentNavigatorKey: _rootNavigator,
          pageBuilder: (context, state) => NoTransitionPage(
              child: NotificationSettingsPage(
                key: state.pageKey,
              )
          )
      ),
      GoRoute(
          path: '/profile-settings',
          parentNavigatorKey: _rootNavigator,
          pageBuilder: (context, state) => NoTransitionPage(
              child: ProfileSettingsPage(
                key: state.pageKey,
              )
          )
      ),
      GoRoute(
          path: '/app-info',
          parentNavigatorKey: _rootNavigator,
          pageBuilder: (context, state) => NoTransitionPage(
              child: AppInfoPage(
                key: state.pageKey,
              )
          )
      ),
      GoRoute(
          path: '/app-help',
          parentNavigatorKey: _rootNavigator,
          pageBuilder: (context, state) => NoTransitionPage(
              child: AppHelpPage(
                key: state.pageKey,
              )
          )
      )
    ]
);