import 'package:daylog/pages/daylog/daylog_page.dart';
import 'package:daylog/pages/home/home_page.dart';
import 'package:daylog/pages/login/login_page.dart';
import 'package:daylog/pages/scheduler/sheduler_page.dart';
import 'package:daylog/pages/scheduler_log/s%D1%81heduler_log_page.dart';
import 'package:daylog/pages/signup/signup_page.dart';
import 'package:daylog/pages/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter router = GoRouter(routes: <GoRoute>[
    GoRoute(
      path: splash,
      builder: (BuildContext context, GoRouterState state) {
        return const SplashPage();
      },
    ),
    GoRoute(
      path: login,
      builder: (BuildContext context, GoRouterState state) {
        return const LoginPage();
      },
    ),
    GoRoute(
      path: signUp,
      builder: (BuildContext context, GoRouterState state) {
        return const SignUpPage();
      },
    ),
    GoRoute(
      path: home,
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
    ),
    GoRoute(
      path: daylog,
      builder: (BuildContext context, GoRouterState state) {
        return DaylogPage(id: state.params['id'] as String?);
      },
    ),
    GoRoute(
      path: scheduler,
      builder: (BuildContext context, GoRouterState state) {
        return const SchedulerPage();
      },
    ),
    GoRoute(
      path: schedulerLog,
      builder: (BuildContext context, GoRouterState state) {
        return SchedulerLogPage(id: state.extra as String?);
      },
    ),
    GoRoute(
      path: daylog2,
      builder: (BuildContext context, GoRouterState state) {
        return DaylogPage(id: state.extra as String?);
      },
    ),
  ]);

  static const String splash = '/';
  static const String login = '/login';
  static const String signUp = '/signUp';
  static const String home = '/home';
  static const String daylog = '/daylog/:id';
  static const String scheduler = '/scheduler';
  static const String schedulerLog = '/schedulerLog';
  static const String daylog2 = '/daylog2';
}
