import 'package:daylog/models/event.dart';
import 'package:flutter/material.dart';


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
        iconDisabledColor: Colors.red,
        iconEnabledColor: Colors.brown[800],
        dropdownColor: Colors.brown[800],
        value: dropdownValue,
        icon: const Icon(Icons.arrow_downward),
        elevation: 16,
        underline: Container(
          height: 2,
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
