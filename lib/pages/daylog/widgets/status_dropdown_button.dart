import 'package:flutter/material.dart';

import '../../../models/event.dart';  // TODO(Kseniya): полный путь import 'package:daylog/models/event.dart';

class StatusDropdownButton extends StatelessWidget {
  const StatusDropdownButton({
    Key? key,
    required this.dropdownValue,
    required this.onChanged,
  }) : super(key: key);

  final EventStatus dropdownValue;
  final void Function(EventStatus?) onChanged;  // TODO(Kseniya): пустую строку после добавь
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: DropdownButton<EventStatus>(
        iconDisabledColor: Colors.red,
        iconEnabledColor: Colors.brown[800],
        dropdownColor: Colors.brown[800],

        value: dropdownValue,
        icon: const Icon(Icons.arrow_downward),
        elevation: 16,
        //style: const TextStyle(color: Colors.white), // TODO(Kseniya): удали
        underline: Container(
          height: 2,
          // color: Colors.black12, // TODO(Kseniya): удали
        ),
        onChanged: onChanged,
        items: EventStatus.values
            .map<DropdownMenuItem<EventStatus>>((EventStatus value) {
          return DropdownMenuItem<EventStatus>(
            value: value,
            child: Text(value.label),
          );
        }).toList(),
      ),
    );
  }
}
