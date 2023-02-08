import 'package:flutter/material.dart';

import '../../../models/event.dart';

class StatusDropdownButton extends StatelessWidget {
  const StatusDropdownButton({
    Key? key,
    required this.dropdownValue,
    required this.onChanged,
  }) : super(key: key);

  final EventStatus dropdownValue;
  final void Function(EventStatus?) onChanged;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: DropdownButton<EventStatus>(
        value: dropdownValue,
        icon: const Icon(Icons.arrow_downward),
        elevation: 16,
        style: const TextStyle(color: Colors.white),
        underline: Container(
          height: 2,
          color: Colors.black12,
        ),
        onChanged: onChanged,
        items: EventStatus.values.map<DropdownMenuItem<EventStatus>>((EventStatus value) {
          return DropdownMenuItem<EventStatus>(
            value: value,
            child: Text(value.label),
          );
        }).toList(),
      ),
    );
  }
}
