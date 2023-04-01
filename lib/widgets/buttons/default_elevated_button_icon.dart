import 'package:flutter/material.dart';

class DefaultElevatedButtonIcon extends StatelessWidget {
  const DefaultElevatedButtonIcon({
    Key? key,
    required this.label,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        elevation: 3,
        backgroundColor: Colors.brown[900],
      ),
    );
  }
}
