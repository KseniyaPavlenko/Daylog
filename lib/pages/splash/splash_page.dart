import 'dart:async';

import 'package:daylog/common/route/router.dart';
import 'package:daylog/cubits/auth/auth_cubit.dart';
import 'package:daylog/widgets/scaffold/common_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) => _checkAuth());
  }

  void initStateX() {
    _timer = Timer(
      const Duration(seconds: 3),
      () => context.go(AppRouter.login),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _toHome() => context.go(AppRouter.home); 
  void _toLogin() => context.go(AppRouter.login);

  void _checkAuth() async {
    final authCubit = context.read<AuthCubit>();
    await authCubit.loadData();
    if (authCubit.state.isAuthorized ?? false) {
      _toHome();
    } else {
      _toLogin();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: const Center(
        child: Text(
          'Daily Planner',
          textDirection: TextDirection.ltr,
          style: TextStyle(
            fontSize: 45,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
