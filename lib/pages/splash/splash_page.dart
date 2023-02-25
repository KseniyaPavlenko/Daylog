import 'dart:async';

import 'package:daylog/common/route/router.dart';
import 'package:daylog/cubits/auth/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Timer? timer;

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback(
      (_) => _checkAuth(),
    );
  }

  void initStateX() {
    super.initState();
    timer = Timer(
      const Duration(seconds: 3),
      () {
        context.go(AppRouter.login);
      },
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void _checkAuth() async {
    context.go(AppRouter.login);
    // context.go(AppRouter.home);
    // final authCubit = context.read<AuthCubit>();
    // await authCubit.loadData();
    // if (authCubit.state.isAuthorized ?? false) {
    //   context.go(AppRouter.home);
    // } else {
    //   context.go(AppRouter.login);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
