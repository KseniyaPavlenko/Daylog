import 'package:daylog/common/route/router.dart';
import 'package:daylog/widgets/scaffold/common_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text('Page not found'),
            ElevatedButton(
              onPressed: () => context.go(AppRouter.splash),
              child: const Text('To Home'),
            ),
          ],
        ),
      ),
    );
  }
}
