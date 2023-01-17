// ignore_for_file: non_constant_identifier_names, unnecessary_null_comparison, unused_local_variable, avoid_print, avoid_function_literals_in_foreach_calls, file_names

import 'package:daylog/pages/home_/home_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SchedulerLogPage extends StatefulWidget {
  const SchedulerLogPage({Key? key}) : super(key: key);

  @override
  State<SchedulerLogPage> createState() => _SchedulerLogPageState();
}

class _SchedulerLogPageState extends State<SchedulerLogPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  TextEditingController Enddateinput = TextEditingController();
  TextEditingController Startdateinput = TextEditingController();
  TimeOfDay time = const TimeOfDay(hour: 00, minute: 00);
  String getText() {
    if (time == null) {
      return 'Select Time';
    } else {
      return '${time.hour}:${time.minute}';
    }
  }

  @override
  void initState() {
    Startdateinput.text = "";
    Enddateinput.text = "";
    super.initState();
  }

  final allChecked = CheckBoxModal(title: 'Every day');
  final CheckBoxList = [
    CheckBoxModal(title: 'Sunday'),
    CheckBoxModal(title: 'Monday'),
    CheckBoxModal(title: 'Tuesday'),
    CheckBoxModal(title: 'Wednesday'),
    CheckBoxModal(title: 'Thursday'),
    CheckBoxModal(title: 'Friday'),
    CheckBoxModal(title: 'Saturday'),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leadingWidth: 100,
          leading: ElevatedButton.icon(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomePage()));
            },
            // onPressed: () => context.go(AppRouter.home),
            icon: const Icon(Icons.arrow_left_sharp),
            label: const Text('Back'),
            style: ElevatedButton.styleFrom(
                elevation: 0, backgroundColor: Colors.transparent),
          ),
          title: const Text("Scheduler Log"),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                shape: const CircleBorder(
                    side: BorderSide(color: Colors.transparent)),
              ),
              onPressed: () {},
              child: const Text("Save"),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 30, right: 30, left: 30),
            child: Column(
              children: [
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
                TextField(
                  controller: Startdateinput,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.calendar_today),
                      border: InputBorder.none,
                      hintText: "Choose Start Date",
                      fillColor: Colors.black12,
                      filled: true),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101));

                    if (pickedDate != null) {
                      print(pickedDate);
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      print(formattedDate);

                      setState(() {
                        Startdateinput.text = formattedDate;
                      });
                    } else {
                      print("Date is not selected");
                    }
                  },
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
                      final newTime = await showTimePicker(
                          context: context, initialTime: time);
                      if (newTime == null) return;
                      Text('${time.hour}:${time.minute}');
                      setState(() => time = newTime);
                    }),
                TextField(
                  controller: Enddateinput,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.calendar_today),
                      border: InputBorder.none,
                      hintText: "Choose End Date",
                      fillColor: Colors.black12,
                      filled: true),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101));

                    if (pickedDate != null) {
                      print(pickedDate);
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      print(formattedDate);

                      setState(() {
                        Enddateinput.text = formattedDate;
                      });
                    } else {
                      print("Date is not selected");
                    }
                  },
                ),
                ListTile(
                  onTap: () => onAllClicked(allChecked),
                  leading: Checkbox(
                      value: allChecked.value,
                      onChanged: (value) => onAllClicked(allChecked)),
                  title: Text(allChecked.title),
                ),
                const Divider(),
                ...CheckBoxList.map(
                  (item) => ListTile(
                    onTap: () => onItemClicked(item),
                    leading: Checkbox(
                        value: item.value,
                        onChanged: (value) => onItemClicked(item)),
                    title: Text(item.title),
                  ),
                ).toList()
              ],
            ),
          ),
        ),
      );

  onAllClicked(CheckBoxModal ckbItem) {
    final newValue = !ckbItem.value;
    setState(() {
      ckbItem.value = newValue;
      CheckBoxList.forEach((element) {
        element.value = newValue;
      });
    });
  }

  onItemClicked(CheckBoxModal ckbItem) {
    final newValue = !ckbItem.value;
    setState(() {
      ckbItem.value = newValue;

      if (!newValue) {
        allChecked.value = false;
      } else {
        final allListChecked = CheckBoxList.every((element) => element.value);
        allChecked.value = allListChecked;
      }
    });
  }
}

class CheckBoxModal {
  String title;
  bool value;
  CheckBoxModal({required this.title, this.value = false});
}
