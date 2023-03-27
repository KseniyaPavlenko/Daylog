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
        backgroundColor: Colors.brown, 
        //backgroundColor: Colors.brown[900],
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );
  }
}
