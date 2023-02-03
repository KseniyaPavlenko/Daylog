import 'package:daylog/pages/daylog/daylog_page.dart';
import 'package:daylog/pages/home/home_page.dart';
import 'package:daylog/pages/login/login_page.dart';
import 'package:daylog/pages/scheduler/sheduler_page.dart';
import 'package:daylog/pages/signup/signup_page.dart';
import 'package:daylog/pages/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../pages/scheduler_log/sсheduler_log_page.dart';

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
        return const DaylogPage();
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
        return const SchedulerLogPage();
      },
    ),
  ]);

  static const String splash = '/';
  static const String login = '/login';
  static const String signUp = '/sugnUp';
  static const String home = '/home';
  static const String daylog = '/daylog';
  static const String scheduler = '/scheduler';
  static const String schedulerLog = '/schedulerLog';
}
