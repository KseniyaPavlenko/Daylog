import 'package:daylog/cubits/auth/auth_cubit.dart';
import 'package:daylog/models/event.dart';
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
        path: _splash,
        name: _splashName,
        builder: (BuildContext context, GoRouterState state) {
          return const SplashPage();
        },
      ),
      GoRoute(
        path: _login,
        name: _loginName,
        builder: (BuildContext context, GoRouterState state) {
          return const LoginPage();
        },
      ),
      GoRoute(
        path: _signUp,
        name: _signUpName,
        builder: (BuildContext context, GoRouterState state) {
          return const SignUpPage();
        },
      ),
      GoRoute(
        path: _home,
        name: _homeName,
        builder: (BuildContext context, GoRouterState state) {
          return const HomePage();
        },
      ),
      GoRoute(
        path: _daylog,
        name: _daylogName,
        builder: (BuildContext context, GoRouterState state) {
          var id = state.params['id'];
          String? draftId;
          if (id == '-1') {
            id = null;
          }
          if (id?.startsWith(Event.draftPrefix) ?? false) {
            draftId = id?.replaceFirst(Event.draftPrefix, '');
            id = null;
          }
          return DaylogPage(id: id, draftId: draftId,);
        },
      ),
      GoRoute(
        path: _scheduler,
        name: _schedulerName,
        builder: (BuildContext context, GoRouterState state) {
          return const SchedulerPage();
        },
      ),
      GoRoute(
        path: _schedulerLog,
        name: _schedulerLogName,
        builder: (BuildContext context, GoRouterState state) {
          var id = state.params['id'];
          if (id == '-1') {
            id = null;
          }
          return SchedulerLogPage(id: id);
        },
      ),
      GoRoute(
        path: _notFound,
        builder: (BuildContext context, GoRouterState state) {
          return const NotFoundPage();
        },
      ),
      GoRoute(
        path: _welcome,
        name: _welcomeName,
        builder: (BuildContext context, GoRouterState state) {
          return const WelcomePage();
        },
      ),
      GoRoute(
        path: _pinCode,
        name: _pinCodeName,
        builder: (BuildContext context, GoRouterState state) {
          return const PinCodePage();
        },
      ),
    ],
    errorBuilder: (context, state) => const NotFoundPage(),
    redirect: (context, state) {
      final isAuthorized =
          context.read<AuthCubit>().state.isAuthorized ?? false;

      final locationsWithoutAuth = [
        _splash,
        _login,
        _signUp,
        _notFound,
        _welcome,
      ];
      final isLocWithAuth = !locationsWithoutAuth.contains(state.subloc);
      if (!isAuthorized && isLocWithAuth) {
        return _login;
      }
      return null;
    },
  );

  //routes
  static const String splash = '/';
  static const String login = '/login';
  static const String signUp = '/signUp';
  static const String home = '/home';
  static const String daylog = '/daylog';
  static const String scheduler = '/scheduler';
  static const String schedulerLog = '/schedulerLog';
  static const String notFound = '/*';
  static const String welcome = '/welcome';
  static const String pinCode = '/pinCode';

  //paths
  static const String _splash = '/';
  static const String _login = '/login';
  static const String _signUp = '/signUp';
  static const String _home = '/home';
  static const String _daylog = '/daylog/:id';
  static const String _scheduler = '/scheduler';
  static const String _schedulerLog = '/schedulerLog/:id';
  static const String _notFound = '/*';
  static const String _welcome = '/welcome';
  static const String _pinCode = '/pinCode';

  //names
  static const String _splashName = 'splash';
  static const String _loginName = 'login';
  static const String _signUpName = 'signUp';
  static const String _homeName = 'home';
  static const String _daylogName = 'daylog';
  static const String _schedulerName = 'scheduler';
  static const String _schedulerLogName = 'schedulerLog';
  static const String _welcomeName = 'welcome';
  static const String _pinCodeName = 'pinCode';
}
