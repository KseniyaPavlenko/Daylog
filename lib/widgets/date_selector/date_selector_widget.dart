import 'package:daylog/common/utils/date_utils.dart';
import 'package:flutter/material.dart';

class DateSelectorWidget extends StatefulWidget {
  const DateSelectorWidget({
    Key? key,
    required this.date,
    required this.onChange,
  }) : super(key: key);

  final DateTime date;
  final ValueChanged<DateTime>? onChange;

  @override
  State<DateSelectorWidget> createState() => _DateSelectorWidgetState();
}

class _DateSelectorWidgetState extends State<DateSelectorWidget> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.date;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: double.infinity,
      // color: Colors.grey[600],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            key: const Key('dateSelector_prev'),
            onTap: () { // TODO(Kseniya): вынеси в функцию onTap...
              setState(() {
                _selectedDate = _selectedDate.subtract(const Duration(days: 1));
              });
              widget.onChange?.call(_selectedDate);
            },
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
                key: const Key('day'),
                _selectedDate.day.toString(),
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                key: const Key('month'),
                _selectedDate.toMonth(),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          InkWell(
            key: const Key('dateSelector_next'),
            onTap: () {
              // TODO(Kseniya): вынеси в функцию _onTap...
              setState(() {
                _selectedDate = _selectedDate.add(const Duration(days: 1));
              });
              widget.onChange?.call(_selectedDate);
              // widget.onRightTap;
            },
            child: const Icon(Icons.arrow_right, size: 50),
          ),
        ],
      ),
    );
  }
}
