import 'package:flutter/material.dart';

class DefaultFloatingActionButton extends StatelessWidget {
  const DefaultFloatingActionButton({
    Key? key,
    required this.onTap,
    required this.isEnabled,
    this.tooltip,
    required this.text, 
  }) : super(key: key);

  final VoidCallback onTap;
  final bool isEnabled;
  final String? tooltip;
  final String text;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: isEnabled ? onTap : null,
      tooltip: tooltip,
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
