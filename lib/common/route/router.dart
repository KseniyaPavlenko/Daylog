import 'package:daylog/pages/daylog/daylog_page.dart';
import 'package:daylog/pages/home/home_page.dart';
import 'package:daylog/pages/login/login_page.dart';
import 'package:daylog/pages/scheduler/scheduler_page.dart';
import 'package:daylog/pages/scheduler_log/scheduler_log_page.dart';
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
      name: daylogName,
      builder: (BuildContext context, GoRouterState state) {
        return DaylogPage(id: state.params['id']);
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
      name: schedulerLogName,
      builder: (BuildContext context, GoRouterState state) {
        return SchedulerLogPage(id: state.params['id']);
      },
    ),
  ]);

  static const String splash = '/';
  static const String login = '/login';
  static const String signUp = '/signUp';
  static const String home = '/home';
  static const String daylog = '/daylog/:id';
  static const String daylogName = 'daylog';
  static const String scheduler = '/scheduler';
  static const String schedulerLog = '/schedulerLog/:id';
  static const String schedulerLogName = 'schedulerLog';
}
