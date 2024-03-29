import 'package:daylog/common/route/router.dart';
import 'package:daylog/common/utils/date_utils.dart';
import 'package:daylog/cubits/event_detail/event_detail_cubit.dart';
import 'package:daylog/cubits/event_detail/event_detail_state.dart';
import 'package:daylog/models/event.dart';
import 'package:daylog/pages/daylog/widgets/dropdown_padding.dart';
import 'package:daylog/widgets/buttons/default_elevated_button_icon.dart';
import 'package:daylog/widgets/default_app_bar/default_app_bar.dart';
import 'package:daylog/widgets/loading_indicator/common_loading_indicator.dart';
import 'package:daylog/widgets/scaffold/common_scaffold.dart';
import 'package:daylog/widgets/text_fields/common_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DaylogPage extends StatefulWidget {
  const DaylogPage({Key? key, required this.id}) : super(key: key);
  final String? id;
  @override
  State<DaylogPage> createState() => _DaylogPageState();
}

class _DaylogPageState extends State<DaylogPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  var _time = const TimeOfDay(hour: 00, minute: 00);
  var _dropdownValue = EventStatus.todo;

  String? _userId;
  DateTime _date = DateTime.now();

  EventDetailCubit get _eventDetailCubit => context.read<EventDetailCubit>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_checkId()) {
        _eventDetailCubit.loadData(widget.id);
      }
    });
  }

  bool _checkId() {
    if (widget.id?.isEmpty ?? true) {
      context.pop();
      return false;
    }
    return true;
  }

  void _onTapSave() async {
    await _eventDetailCubit.updateEvent(
      Event(
        id: widget.id,
        userId: _userId,
        title: _titleController.text,
        detail: _detailsController.text,
        comment: _commentController.text,
        startAt: _date.copyWith(minute: _time.minute, hour: _time.hour),
        startDate: _date,
        status: _dropdownValue,
      ),
    );
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
  Widget build(BuildContext context) {
    return CommonScaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: DefaultAppBar(
        title: 'Day Log',
        leading: DefaultElevatedButtonIcon(
          label: 'Back',
          icon: Icons.arrow_left_sharp,
          onTap: () => context.go(AppRouter.home),
        ),
        actions: <Widget>[
          DefaultElevatedButtonIcon(
            label: 'Save',
            icon: Icons.save_outlined,
            onTap: _onTapSave,
          )
        ],
      ),
      body: BlocConsumer<EventDetailCubit, EventDetailState>(
        listener: (context, state) {
          if (state.selectedEvent != null) {
            final event = state.selectedEvent;
            _titleController.text = event?.title ?? '';
            _detailsController.text = event?.detail ?? '';
            _commentController.text = event?.comment ?? '';
            _dropdownValue = event?.status ?? EventStatus.todo;
            _date = event?.startDate ?? DateTime.now();
            _timeController.text = event?.startAt?.toFormatTime(context) ?? '';
          }
        },
        builder: (context, state) {
          return CommonLoadingIndicator(
            isLoading: state.isLoading,
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: RefreshIndicator(
                edgeOffset: 20,
                onRefresh: () => _eventDetailCubit.loadData(widget.id),
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: <Widget>[
                    DropDownPadding(
                      dropdownStatus: _dropdownValue,
                      onChanged: (newValue) {
                        setState(() => _dropdownValue = newValue!);
                      },
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
                      controller: _commentController,
                      hintText: 'Enter Comment',
                    ),
                    CommonTextField(
                      controller: _timeController,
                      hintText: 'Choose Start Time',
                      onTap: () async => _onTapTimeField(),
                      icon: const Icon(Icons.more_time_outlined),
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
}
