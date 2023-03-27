import 'package:flutter/material.dart';
//TODO: text,action общий виджет textButton (title, onTap)
class BackButton extends StatelessWidget {
  const BackButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Theme.of(context).primaryColor,
      ),
      onPressed: onTap,
      child: const Text(
        "Already have an account? Login",
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

//onPressed: () => GoRouter.of(context).go(AppRouter.login),
