import 'package:flutter/material.dart';

class CreateAccountButton extends StatelessWidget {
  const CreateAccountButton({Key? key, required this.onPressed}) : super(key: key);

  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: const Key('CreateAccButton'),
      onPressed: onPressed,
      child: const Text(
        "Create account",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 15,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
