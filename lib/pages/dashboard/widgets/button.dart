import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../common/route/router.dart'; // TODO(Kseniya): переделай в полный путь как выше

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

          /*
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const DaylogPage())); */ // TODO(Kseniya): Удали
        },
      );
    }
  }
}
