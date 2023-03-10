// ignore_for_file: non_constant_identifier_names, unnecessary_null_comparison, unused_local_variable, avoid_print, avoid_function_literals_in_foreach_calls, file_names

import 'package:daylog/common/route/router.dart';
import 'package:daylog/cubits/draft_detail/draft_detail_cubit.dart';
import 'package:daylog/cubits/draft_detail/draft_detail_state.dart';
import 'package:daylog/models/day_of_week.dart';
import 'package:daylog/models/draft.dart';
import 'package:daylog/pages/scheduler_log/widgets/day_of_week_selector.dart';
import 'package:daylog/widgets/loading_indicator/common_loading_indicator.dart';
import 'package:daylog/widgets/scaffold/common_scaffold.dart';
import 'package:daylog/widgets/text_fields/common_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:daylog/common/utils/date_utils.dart';

class SchedulerLogPage extends StatefulWidget {
  const SchedulerLogPage({Key? key, this.id}) : super(key: key);
  final String? id;
  @override
  State<SchedulerLogPage> createState() => _SchedulerLogPageState();
}

class _SchedulerLogPageState extends State<SchedulerLogPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _endDateCintroller = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  TimeOfDay time = const TimeOfDay(hour: 00, minute: 00);

  List<DayOfWeek> selectedDayList = [];

  String? userId;
  int? duration;
  int? days;
  DateTime date = DateTime.now();
  DateTime? endDate;

  String getText() {
    if (time == null) {
      return 'Select Time';
    } else {
      return '${time.hour}:${time.minute}';
    }
  }

  DraftDetailCubit get draftDetailCubit => context.read<DraftDetailCubit>();

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (widget.id?.isNotEmpty ?? false) draftDetailCubit.loadData(widget.id);
    });
  }

  void _onTapSave() async {
    await draftDetailCubit.updateDraft(
      Draft(
        id: widget.id,
        userId: userId,
        title: _titleController.text,
        detail: _detailsController.text,
        startAt: date.copyWith(minute: time.minute, hour: time.hour),
        startDate: date,
        endDate: endDate,
        duration: duration,
        days: days,
      ),
    );
    context.pop();
  }

  void onTapDay(DayOfWeek day) {
    setState(() {
      if (selectedDayList.contains(day)) {
        selectedDayList.removeWhere((e) => e == day);
      } else {
        selectedDayList.add(day);
      }
    });
  }

  void _onTapStartDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101));

    if (pickedDate != null) {
      print(pickedDate);
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      print(formattedDate);

      setState(() {
        _startDateController.text = formattedDate;
      });
    } else {
      print("Date is not selected");
    }
  }

  void _onTapEndDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101));

    if (pickedDate != null) {
      print(pickedDate);
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      print(formattedDate);

      setState(() {
        _endDateCintroller.text = formattedDate;
      });
    } else {
      print("Date is not selected");
    }
  }

  void onTapEveryDay() {
    setState(() {
      selectedDayList.clear();
      selectedDayList.addAll(DayOfWeek.values);
    });
  }

  void _onTapTimeField() async {
    const initialTime = TimeOfDay(hour: 00, minute: 00);
    final newTime = await showTimePicker(context: context, initialTime: time);
    if (newTime == null) return;

    setState(() {
      time = newTime;
      _timeController.text = newTime.format(context);
    });
  }

  @override
  Widget build(BuildContext context) => CommonScaffold(
      backgroundColor: Theme.of(context).primaryColor,
      // resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leadingWidth: 100,
        leading: ElevatedButton.icon(
          onPressed: () => context.go(AppRouter.home),
          icon: const Icon(Icons.arrow_left_sharp),
          label: const Text('Back'),
          style: ElevatedButton.styleFrom(
            elevation: 3,
            //backgroundColor: Colors.brown[900],
          ),
        ),
        title: const Text("Scheduler Log"),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        actions: <Widget>[
          ElevatedButton.icon(
            onPressed: _onTapSave,
            icon: const Icon(Icons.save_outlined),
            label: const Text('Save'),
            style: ElevatedButton.styleFrom(
              elevation: 3,
              backgroundColor: Colors.brown[900],
            ),
          ),
        ],
      ),
      body: BlocConsumer<DraftDetailCubit, DraftDetailState>(
        listener: (context, state) {
          if (state.selectedDraft != null) {
            final draft = state.selectedDraft;
            _titleController.text = draft?.title ?? '';
            _detailsController.text = draft?.detail ?? '';
            date = draft?.startDate ?? DateTime.now();
            _timeController.text = draft?.startAt?.toFormatTime(context) ?? '';
          }
        },
        builder: (context, state) {
          return CommonLoadingIndicator(
            isLoading: state.isLoading,
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: RefreshIndicator(
                edgeOffset: 20,
                onRefresh: () => draftDetailCubit.loadData(widget.id),
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      ),
                    ),
                    CommonTextField(
                      controller: _titleController,
                      hintText: 'Enter Title',
                    ),
                    CommonTextField(
                      controller: _detailsController,
                      hintText: 'Enter Details',
                    ),
                    CommonTextField(
                      controller: _startDateController,
                      hintText: "Choose Start Date",
                      icon: const Icon(Icons.calendar_today_outlined),
                      onTap: _onTapStartDate,
                    ),
                    CommonTextField(
                      controller: _timeController,
                      hintText: 'Choose Start Time',
                      onTap: () async => _onTapTimeField(),
                      icon: const Icon(Icons.more_time_outlined),
                    ),
                    //////////
                    CommonTextField(
                      controller: _endDateCintroller,
                      hintText: "Choose End Date",
                      icon: const Icon(Icons.edit_calendar_outlined),
                      onTap: _onTapEndDate,
                    ),
                    const SizedBox(height: 16),
                    DayOfWeekSelector(
                      selected: selectedDayList,
                      onTapDay: onTapDay,
                      onTapEveryDay: onTapEveryDay,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ));
}
