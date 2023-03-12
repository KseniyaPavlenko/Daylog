import 'package:another_flushbar/flushbar.dart';
import 'package:daylog/common/style/app_colors.dart';
import 'package:flutter/material.dart';

extension BuildContextX on BuildContext {
  void showError(
    String message, {
    String? title,
  }) {
    //Flushbar(
    Flushbar<dynamic>(
      title: title,
      message: message,
      duration: const Duration(seconds: 3),
      titleColor: Colors.red,
      messageColor: AppColors.darkRed,
      backgroundColor: AppColors.lightYellow, // AppColors.lightGreen
      flushbarPosition: FlushbarPosition.BOTTOM,
      boxShadows: const [
        BoxShadow(
          color: AppColors.lightRed,
          offset: Offset(2, 2),
          blurRadius: 8,
        )
      ],
      icon: const Icon(
        Icons.error_outline,
        size: 32,
        color: AppColors.darkRed,
      ),
      shouldIconPulse: true,
    ).show(this);
  }

  double get bottomPadding => MediaQuery.of(this).padding.bottom;

  double get screenWidth => MediaQuery.of(this).size.width;

  double get screenHeight => MediaQuery.of(this).size.height;
}
