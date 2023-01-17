import 'package:daylog/pages/login/login_page.dart';
import 'package:flutter/material.dart';

class BottomWave extends StatelessWidget {
  const BottomWave({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Align(
      child: ClipPath(
        child: Container(
          color: Colors.white,
          height: 300,
        ),
        clipper: BottomWaveClipper(),
      ),
      alignment: Alignment.bottomCenter,
    ));
  }
}
