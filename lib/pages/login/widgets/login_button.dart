import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
    required this.onTap,
    required this.isEnabled,
  }) : super(key: key);

  final VoidCallback onTap;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: isEnabled? onTap : null,
      tooltip: 'LoginButton',
      child: const Text(
        'LOGIN',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 20,
        ),
      ),

    );
  }
}
