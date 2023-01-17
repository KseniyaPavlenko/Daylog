// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:daylog/common/route/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Splash screen that stays visible for 3 seconds
class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  //Declare a timer
  Timer? timer;

  @override
  void initState() {
    super.initState();

    /// Initialize timer for 3 seconds, it will be active as soon as intialized
    timer = Timer(
      const Duration(seconds: 3),
      () {
        context.go(AppRouter.login);
        //GoRouter.of(context).go(AppRouter.login);
      },
    );
  }

  /// cancel the timer when widget is disposed,
  /// to avoid any active timer that is not executed yet
  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text(
          'Daily Planner',
          textDirection: TextDirection.ltr,
          style: TextStyle(
            fontSize: 45,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
