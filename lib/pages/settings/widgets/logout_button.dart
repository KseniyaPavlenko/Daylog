import 'package:flutter/material.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton(
    String text, {
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    String text = "LOGOUT";
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.brown, // TODO(Kseniya): deprecated
        backgroundColor: Colors.brown[900],
      ),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      onPressed: onPressed,
    );
  }
}
