import 'package:flutter/material.dart';

class DefaultTextButton extends StatelessWidget {
  const DefaultTextButton({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);
  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: key,
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 15,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
