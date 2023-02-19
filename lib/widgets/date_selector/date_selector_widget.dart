import 'package:daylog/common/utils/date_utils.dart';
import 'package:flutter/material.dart';

class DateSelectorWidget extends StatelessWidget {
  const DateSelectorWidget({
    Key? key,
    required this.date,
    required this.onLeftTap,
    required this.onRightTap,
  }) : super(key: key);

  final DateTime date;
  final VoidCallback onLeftTap;
  final VoidCallback onRightTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      // color: Colors.grey[600],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: onLeftTap,
            child: const Icon(
              Icons.arrow_left,
              size: 50,
              // color: Colors.white,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                date.day.toString(),
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                date.toMonth(),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          InkWell(
            onTap: onRightTap,
            child: const Icon(
              Icons.arrow_right,
              size: 50,
              //color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
