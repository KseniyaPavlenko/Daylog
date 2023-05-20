import 'dart:async';

import 'package:daylog/common/route/router.dart';
import 'package:daylog/cubits/auth/auth_cubit.dart';
import 'package:daylog/widgets/scaffold/common_scaffold.dart';
import 'package:flutter/foundation.dart';
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
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      _checkAuth();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  //void _toHome() => context.go(AppRouter.home);
 void _toLogin() => context.go(AppRouter.login);
  void _toWelcome() => context.go(AppRouter.welcome);
  void _toPinCode() => context.go(AppRouter.pinCode);

  void _checkAuth() async {
    final authCubit = context.read<AuthCubit>();
    await authCubit.loadData();
    _toPinCode();
//_toWelcome();

     if (kIsWeb) {
        _toWelcome();
      } else {
        _toLogin();
      }
    
    
    //
    // if (authCubit.state.isAuthorized ?? false) {
    //   _toHome();
    // } else {
    //   if (kIsWeb) {
    //     _toWelcome();
    //   } else {
    //     _toLogin();
    //   }
    // }
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
