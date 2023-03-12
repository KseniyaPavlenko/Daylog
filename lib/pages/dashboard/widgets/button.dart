import 'package:daylog/common/route/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class Button extends StatelessWidget {
  const Button(String text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    {
      String text = "Daylog";
      return ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.brown[100]),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        onPressed: () {
          context.go(AppRouter.daylog); // TODO(Kseniya): Реализацию вынеси в dashboard_page, а сюда передай callback
        },
      );
    }
  }
}
