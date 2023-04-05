import 'package:flutter/material.dart';

class DefaultAppBarIconButton extends StatelessWidget {
  const DefaultAppBarIconButton({
    Key? key,
    required this.label,
    required this.icon,
    required this.onTap,
    this.style,
  }) : super(key: key);

  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon),
      label: Text(label),
      style: style,
    );
  }
}
