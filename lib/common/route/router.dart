import 'package:daylog/cubits/auth/auth_cubit.dart';
import 'package:daylog/pages/create_passcode/create_passcode_page.dart';
import 'package:daylog/pages/daylog/daylog_page.dart';
import 'package:daylog/pages/home/home_page.dart';
import 'package:daylog/pages/login/login_page.dart';
import 'package:daylog/pages/not_found/not_found_page.dart';
import 'package:daylog/pages/scheduler/scheduler_page.dart';
import 'package:daylog/pages/scheduler_log/scheduler_log_page.dart';
import 'package:daylog/pages/signup/signup_page.dart';
import 'package:daylog/pages/splash/splash_page.dart';
import 'package:daylog/pages/welcome/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: splash,
        name: splashName,
        builder: (BuildContext context, GoRouterState state) {
          return const SplashPage();
        },
      ),
      GoRoute(
        path: login,
        name: loginName,
        builder: (BuildContext context, GoRouterState state) {
          return const LoginPage();
        },
      ),
      GoRoute(
        path: signUp,
        name: signUpName,
        builder: (BuildContext context, GoRouterState state) {
          return const SignUpPage();
        },
      ),
      GoRoute(
        path: home,
        name: homeName,
        builder: (BuildContext context, GoRouterState state) {
          return const HomePage();
        },
      ),
      GoRoute(
        path: daylog,
        name: daylogName,
        builder: (BuildContext context, GoRouterState state) {
          return DaylogPage(id: state.params['id']!);
        },
      ),
      GoRoute(
        path: scheduler,
        name: schedulerName,
        builder: (BuildContext context, GoRouterState state) {
          return const SchedulerPage();
        },
      ),
      GoRoute(
        path: schedulerLog,
        name: schedulerLogName,
        builder: (BuildContext context, GoRouterState state) {
          return SchedulerLogPage(id: state.params['id']!);
        },
      ),
      GoRoute(
        path: notFound,
        builder: (BuildContext context, GoRouterState state) {
          return const NotFoundPage();
        },
      ),
      GoRoute(
        path: welcome,
        name: welcomeName,
        builder: (BuildContext context, GoRouterState state) {
          return const WelcomePage();
        },
      ),
      GoRoute(
        path: pinCode,
        name: pinCodeName,
        builder: (BuildContext context, GoRouterState state) {
          return const PinCodePage();
        },
      ),
    ],
    errorBuilder: (context, state) => const NotFoundPage(),
    redirect: (context, state) {
      final isAuthorized = context.read<AuthCubit>().state.isAuthorized ?? false;

      final locationsWithoutAuth = [
        splash,
        login,
        signUp,
        notFound,
        welcome,
      ];
      final isLocWithAuth = !locationsWithoutAuth.contains(state.subloc);
      if (!isAuthorized && isLocWithAuth) {
        return login;
      }
      return null;
    },
  );

  //paths
  static const String splash = '/';
  static const String login = '/login';
  static const String signUp = '/signUp';
  static const String home = '/home';
  static const String daylog = '/daylog/:id';
  static const String scheduler = '/scheduler';
  static const String schedulerLog = '/schedulerLog/:id';
  static const String notFound = '/*';
  static const String welcome = '/welcome';
  static const String pinCode = '/pinCode';

  //names
  static const String splashName = 'splash';
  static const String loginName = 'login';
  static const String signUpName = 'signUp';
  static const String homeName = 'home';
  static const String daylogName = 'daylog';
  static const String schedulerName = 'scheduler';
  static const String schedulerLogName = 'schedulerLog';
  static const String welcomeName = 'welcome';
  static const String pinCodeName = 'pinCode';
}
