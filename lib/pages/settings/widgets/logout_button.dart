// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton(String text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String text = "LOGOUT";
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Theme.of(context).primaryColor,
      ),
      child: Text(
        text,
        // ignore: prefer_const_constructors
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
      ),
      onPressed: () {},
    );
  }
}
