import 'package:flutter/material.dart';

class WidgetTest extends StatelessWidget {
  final Widget child;

  const WidgetTest({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.white,
      home: Material(
        child: child,
      ),
    );
  }
}
