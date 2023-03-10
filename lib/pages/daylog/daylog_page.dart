// ignore_for_file: deprecated_member_use, unused_local_variable

import 'package:daylog/common/errors/request_error.dart';
import 'package:daylog/common/route/router.dart';
import 'package:daylog/common/utils/date_utils.dart';
import 'package:daylog/common/utils/logger.dart';
import 'package:daylog/cubits/event_detail/event_detail_cubit.dart';
import 'package:daylog/cubits/event_detail/event_detail_state.dart';
import 'package:daylog/models/event.dart';
import 'package:daylog/pages/daylog/widgets/status_dropdown_button.dart';
import 'package:daylog/widgets/loading_indicator/common_loading_indicator.dart';
import 'package:daylog/widgets/scaffold/common_scaffold.dart';
import 'package:daylog/widgets/text_fields/common_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

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
  TimeOfDay time = const TimeOfDay(hour: 00, minute: 00);
  EventStatus dropdownValue = EventStatus.todo;

  var uuid = const Uuid();
  String? userId;
  DateTime date = DateTime.now();
  List logItems = [];

  EventDetailCubit get eventDetailCubit => context.read<EventDetailCubit>();

  @override
  void initState() {
    super.initState();
    if (_checkId()) {
      eventDetailCubit.loadData(widget.id);
    }
  }

  bool _checkId() {
    if (widget.id?.isEmpty ?? true) {
      context.pop();
      return false;
    }
    return true;
  }

  createUuid() {
    const uuid = Uuid();
    //Create UUID version-4
    return uuid.v4();
  }

  void _onTapSave() async {
    try {
      await eventDetailCubit.updateEvent(
        Event(
          id: widget.id,
          userId: userId,
          title: _titleController.text,
          detail: _detailsController.text,
          comment: _commentController.text,
          startAt: date.copyWith(minute: time.minute, hour: time.hour),
          startDate: date,
          status: dropdownValue,
        ),
      );
      context.pop();
    } on RequestError catch (e) {
      final message = e.toString();
      // Show toast
      log.e(e);
    } catch (e) {
      log.e(e);
    }
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

  // _backButton() {
  //   ElevatedButton.icon(
  //     onPressed: () => context.go(AppRouter.home),
  //     icon: const Icon(Icons.arrow_left_sharp),
  //     label: const Text('Back'),
  //     style: ElevatedButton.styleFrom(
  //       elevation: 3,
  //       primary: Colors.brown[900],
  //     ),
  //   );
  // }

  // _saveButton() {
  //   ElevatedButton.icon(
  //       onPressed:_onTapSave,
  //       icon: const Icon(Icons.save_outlined),
  //       label: const Text('Save'),
  //       style: ElevatedButton.styleFrom(
  //       elevation: 3,
  //       primary: Colors.brown[900],
  //     ),
  //   ),
  // }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leadingWidth: 100,
        leading: ElevatedButton.icon(
          onPressed: () => context.go(AppRouter.home),
          icon: const Icon(Icons.arrow_left_sharp),
          label: const Text('Back'),
          style: ElevatedButton.styleFrom(
              elevation: 3,
              primary: Colors.brown[900],
              minimumSize: const Size(1000, 1000)),
        ),
        title: const Text('Day Log'),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        actions: <Widget>[
          ElevatedButton.icon(
            onPressed: _onTapSave,
            icon: const Icon(Icons.save_outlined),
            label: const Text('Save'),
            style: ElevatedButton.styleFrom(
              elevation: 3,
              primary: Colors.brown[900],
            ),
          ),
        ],
      ),
      body: BlocConsumer<EventDetailCubit, EventDetailState>(
        listener: (context, state) {
          if (state.selectedEvent != null) {
            final event = state.selectedEvent;
            _titleController.text = event?.title ?? '';
            _detailsController.text = event?.detail ?? '';
            _commentController.text = event?.comment ?? '';
            dropdownValue = event?.status ?? EventStatus.todo;
            date = event?.startDate ?? DateTime.now();
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
                onRefresh: () => eventDetailCubit.loadData(widget.id),
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Date: ${date.year}.${date.month}.${date.day}',
                            // style: const TextStyle(
                            //   fontSize: 18,
                            //   fontWeight: FontWeight.bold,
                            //   color: Colors.white,
                            // ),
                          ),
                          StatusDropdownButton(
                            dropdownValue: dropdownValue,
                            onChanged: (newValue) {
                              setState(() => dropdownValue = newValue!);
                            },
                          ),
                        ],
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
