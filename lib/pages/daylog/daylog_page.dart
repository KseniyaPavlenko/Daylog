import 'package:daylog/common/route/router.dart';
import 'package:daylog/common/style/app_colors.dart';
import 'package:daylog/common/utils/date_utils.dart';
import 'package:daylog/cubits/event_detail/event_detail_cubit.dart';
import 'package:daylog/cubits/event_detail/event_detail_state.dart';
import 'package:daylog/cubits/event_list/event_list_cubit.dart';
import 'package:daylog/models/event.dart';
import 'package:daylog/pages/daylog/widgets/dropdown_padding.dart';
import 'package:daylog/widgets/buttons/default_app_bar_icon_button.dart';
import 'package:daylog/widgets/default_app_bar/default_app_bar.dart';
import 'package:daylog/widgets/loading_indicator/common_loading_indicator.dart';
import 'package:daylog/widgets/scaffold/common_scaffold.dart';
import 'package:daylog/widgets/text_fields/common_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DaylogPage extends StatefulWidget {
  const DaylogPage({Key? key, required this.id, this.isUpdating, this.draftId})
      : super(key: key);
  final String? id;
  final String? draftId;

  final bool? isUpdating;
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
  EventListCubit get _eventListCubit => context.read<EventListCubit>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // if (_checkId()) {
      Event? draftEvent;
      if (widget.draftId != null) {
        final eventDraftId = '${Event.draftPrefix}${widget.draftId}';
        draftEvent = _eventListCubit.state.events
            ?.firstWhere((e) => e.id == eventDraftId);
      }
      _eventDetailCubit.loadData(widget.id, draftEvent: draftEvent);
      //   }
    });
  }

  // bool _checkId() {
  //   if (widget.id?.isEmpty ?? true) {
  //     context.pop();
  //     return false;
  //   }
  //   return true;
  // }

  void _pop() => context.pop();
  void _onTapSave() async {
    await _eventDetailCubit.updateEvent(
      Event(
        id: widget.id,
        userId: _userId,
        draftId: widget.draftId,
        title: _titleController.text,
        detail: _detailsController.text,
        comment: _commentController.text,
        startAt: _date.copyWith(minute: _time.minute, hour: _time.hour),
        startDate: _date,
        status: _dropdownValue,
      ),
    );
    await _eventListCubit.loadData();
    _pop();
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
        leading: DefaultAppBarIconButton(
          label: 'Back',
          icon: Icons.arrow_left_sharp,
          onTap: () => context.go(AppRouter.home),
          // onTap: () => context.pop(),
          style: ButtonStyle(
            fixedSize: MaterialStateProperty.all<Size>(const Size(100, 50)),
            backgroundColor:
                MaterialStateProperty.all<Color>(AppColors.darkRed2),
          ),
        ),
        actions: <Widget>[
          DefaultAppBarIconButton(
            label: 'Save',
            icon: Icons.save_outlined,
            onTap: _onTapSave,
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all<Size>(const Size(100, 50)),
              backgroundColor:
                  MaterialStateProperty.all<Color>(AppColors.darkRed2),
            ),
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
                    // CommonTextField(
                    //   controller: _commentController,
                    //   hintText: 'Enter Comment',
                    // ),
                    CommonTextField(
                      controller: _timeController,
                      hintText: 'Choose Start Time',
                      onTap: () async => _onTapTimeField(),
                      icon: const Icon(Icons.more_time_outlined),
                    ),
                    const SizedBox(height: 40),
                    if (widget.id != null && widget.draftId == null)
                      SizedBox(
                        width: 60,
                        height: 40,
                        child: Align(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            onPressed: _onDelete,
                            style: ElevatedButton.styleFrom(
                              textStyle: const TextStyle(fontSize: 20),
                              backgroundColor: Colors.red[300],
                              foregroundColor: Colors.white,
                              elevation: 10,
                              shadowColor: Colors.red[400],
                            ),
                            child: const Text('Delete'),
                          ),
                        ),
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

  void _onDelete() {
    _eventListCubit.deleteEvent(widget.id!);
    context.pop();
  }
}
