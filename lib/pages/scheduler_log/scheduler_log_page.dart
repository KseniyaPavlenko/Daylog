import 'package:daylog/common/route/router.dart';
import 'package:daylog/cubits/draft_detail/draft_detail_cubit.dart';
import 'package:daylog/cubits/draft_detail/draft_detail_state.dart';
import 'package:daylog/models/day_of_week.dart';
import 'package:daylog/models/draft.dart';
import 'package:daylog/pages/scheduler_log/widgets/day_of_week_selector.dart';
import 'package:daylog/widgets/buttons/default_elevated_button_icon.dart';
import 'package:daylog/widgets/default_app_bar/default_app_bar.dart';
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
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  TimeOfDay _time = const TimeOfDay(hour: 00, minute: 00);

  final List<DayOfWeek> _selectedDayList = [];

  String? _userId;
  int? _duration;
  int? _days;
  DateTime _date = DateTime.now();
  DateTime? _endDate;

  String get text {
    if (_time == null) {
      return 'Select Time';
    } else {
      return '${_time.hour}:${_time.minute}';
    }
  }

  DraftDetailCubit get _draftDetailCubit => context.read<DraftDetailCubit>();

  @override
  void initState() {
    super.initState();
    if ((widget.id ?? '-1') != '-1') {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _draftDetailCubit.loadData(widget.id);
      });
    }
  }

  void _pop() => context.pop();
  void _onTapSave() async {
    await _draftDetailCubit.updateDraft(
      Draft(
        id: widget.id,
        userId: _userId,
        title: _titleController.text,
        detail: _detailsController.text,
        startAt: _date.copyWith(minute: _time.minute, hour: _time.hour),
        startDate: _date,
        endDate: _endDate,
        duration: _duration,
        days: _days,
      ),
    );
    _pop();
  }

  void _onTapDay(DayOfWeek day) {
    setState(() {
      if (_selectedDayList.contains(day)) {
        _selectedDayList.removeWhere((e) => e == day);
      } else {
        _selectedDayList.add(day);
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
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

      if (mounted) {
        setState(() {
          _startDateController.text = formattedDate;
        });
      }
    } else {}
  }

  void _onTapEndDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101));

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);

      if (mounted) {
        setState(() {
          _endDateController.text = formattedDate;
        });
      }
    } else {}
  }

  void onTapEveryDay() {
    setState(() {
      _selectedDayList.clear();
      _selectedDayList.addAll(DayOfWeek.values);
    });
  }

  void _onTapTimeField() async {
    final newTime = await showTimePicker(context: context, initialTime: _time);
    if (newTime == null) return;
    if (mounted) {
      setState(() {
        _time = newTime;
        _timeController.text = newTime.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) => CommonScaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: DefaultAppBar(
          title: "Scheduler Log",
          leading: DefaultElevatedButtonIcon(
            icon: Icons.arrow_left_sharp,
            label: 'Back',
            onTap: () => context.go(AppRouter.home),
          ),
          actions: <Widget>[
            DefaultElevatedButtonIcon(
              icon: Icons.save_outlined,
              label: 'Save',
              onTap: _onTapSave,
            )
          ],
        ),
        body: BlocConsumer<DraftDetailCubit, DraftDetailState>(
          listener: (context, state) {
            if (state.selectedDraft != null) {
              final draft = state.selectedDraft;
              _titleController.text = draft?.title ?? '';
              _detailsController.text = draft?.detail ?? '';
              _date = draft?.startDate ?? DateTime.now();
              _timeController.text =
                  draft?.startAt?.toFormatTime(context) ?? '';
            }
          },
          builder: (context, state) {
            return CommonLoadingIndicator(
              isLoading: state.isLoading,
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: RefreshIndicator(
                  edgeOffset: 20,
                  onRefresh: () => _draftDetailCubit.loadData(widget.id),
                  child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
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
                      CommonTextField(
                        controller: _endDateController,
                        hintText: "Choose End Date",
                        icon: const Icon(Icons.edit_calendar_outlined),
                        onTap: _onTapEndDate,
                      ),
                      const SizedBox(height: 16),
                      DayOfWeekSelector(
                        selected: _selectedDayList,
                        onTapDay: _onTapDay,
                        onTapEveryDay: onTapEveryDay,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
}
