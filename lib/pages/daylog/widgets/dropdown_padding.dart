import 'package:daylog/models/event.dart';
import 'package:daylog/pages/daylog/widgets/status_dropdown_button.dart';
import 'package:flutter/material.dart';

class DropDownPadding extends StatelessWidget {
  DropDownPadding(
      {Key? key, required this.onChanged, required this.dropdownStatus})
      : super(key: key);

  final EventStatus dropdownStatus;
  final void Function(EventStatus?) onChanged;

  final DateTime _date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Date: ${_date.year}.${_date.month}.${_date.day}',
          ),
          StatusDropdownButton(
            dropdownValue: dropdownStatus,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
