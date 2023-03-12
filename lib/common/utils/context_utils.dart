import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

extension BuildContextX on BuildContext {
  void showError(
    String message, {
    String? title,
  }) {
    Flushbar(
      title: title,
      message: message,
      duration: const Duration(seconds: 3),
      titleColor: Colors.red,
      messageColor: const Color.fromARGB(255, 114, 37, 31),
      // TODO(Kseniya): вынести все цвета в AppColors и дергать их оттуда
      backgroundColor: const Color(0x00faebd7), // AppColors.lightGreen
      flushbarPosition: FlushbarPosition.BOTTOM,
      boxShadows: const [
        BoxShadow(
          color: Color.fromARGB(255, 208, 173, 170),
          offset: Offset(2, 2),
          blurRadius: 8,
        )
      ],
      icon: const Icon(
        Icons.error_outline,
        size: 32,
        color: Color.fromARGB(255, 114, 37, 31),
      ),
      shouldIconPulse: true,
    ).show(this);
  }

  double get bottomPadding => MediaQuery.of(this).padding.bottom;

  double get screenWidth => MediaQuery.of(this).size.width;

  double get screenHeight => MediaQuery.of(this).size.height;
}
