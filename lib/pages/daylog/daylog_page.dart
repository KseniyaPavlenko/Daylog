// ignore_for_file: deprecated_member_use, unused_local_variable

import 'package:daylog/common/route/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

class DaylogPage extends StatefulWidget {
  const DaylogPage({Key? key}) : super(key: key);

  @override
  State<DaylogPage> createState() => _DaylogPageState();
}

class _DaylogPageState extends State<DaylogPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  TimeOfDay time = const TimeOfDay(hour: 00, minute: 00);
  String dropdownValue = 'TODO';

  var uuid = const Uuid();
  String? userId;
  DateTime? date;
  List logItems = [];

  createUuid() {
    const uuid = Uuid();
    //Create UUID version-4
    return uuid.v4();
  }

  @override
  Widget build(BuildContext context) {
    DateTime initialDate = DateTime.now();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leadingWidth: 100,
        leading: ElevatedButton.icon(
          onPressed: () => context.go(AppRouter.home),
          icon: const Icon(Icons.arrow_left_sharp),
          label: const Text('Back'),
          style: ElevatedButton.styleFrom(
              elevation: 0, primary: Colors.transparent),
        ),
        title: const Text('Day Log'),
        centerTitle: true,
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              primary: Colors.white,
              shape: const CircleBorder(
                  side: BorderSide(color: Colors.transparent)),
            ),
            child: const Text("Save"),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 10, right: 2, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'ID: ${uuid.v4()}',
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              'Date: ${initialDate.year}.${initialDate.month}.${initialDate.day}',
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter Title",
                  fillColor: Colors.black12,
                  filled: true,
                  suffix: GestureDetector(
                      onTap: () {
                        _titleController.clear();
                      },
                      child: const Icon(Icons.clear))),
            ),
            TextFormField(
              controller: _detailsController,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter Details",
                  fillColor: Colors.black12,
                  filled: true,
                  suffix: GestureDetector(
                      onTap: () {
                        _detailsController.clear();
                      },
                      child: const Icon(Icons.clear))),
            ),
            TextFormField(
              controller: _commentController,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter Comment",
                  fillColor: Colors.black12,
                  filled: true,
                  suffix: GestureDetector(
                      onTap: () {
                        _commentController.clear();
                      },
                      child: const Icon(Icons.clear))),
            ),
            TextField(
                decoration: const InputDecoration(
                    icon: Icon(Icons.more_time_outlined),
                    border: InputBorder.none,
                    hintText: "Choose Start Time",
                    fillColor: Colors.black12,
                    filled: true),
                readOnly: true,
                onTap: () async {
                  const initialTime = TimeOfDay(hour: 00, minute: 00);
                  final newTime =
                      await showTimePicker(context: context, initialTime: time);
                  if (newTime == null) return;
                  Text('${time.hour}:${time.minute}');
                  setState(() => time = newTime);
                }),
            DropdownButton<String>(
              value: dropdownValue,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              style: const TextStyle(color: Colors.white),
              underline: Container(
                height: 2,
                color: Colors.black12,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: <String>['TODO', 'In Progress', 'Done']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}
