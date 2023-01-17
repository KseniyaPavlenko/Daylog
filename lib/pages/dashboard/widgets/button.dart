import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../common/route/router.dart';

class Button extends StatelessWidget {
  const Button(String text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    {
      String text = "Daylog";
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
        ),
        child: Text(
          text,
          // ignore: prefer_const_constructors
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
        ),
        onPressed: () {
          context.go(AppRouter.daylog);

          /* 
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const DaylogPage())); */
        },
      );
    }
  }
}
