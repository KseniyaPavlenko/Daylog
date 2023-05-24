import 'package:daylog/common/route/router.dart';
import 'package:daylog/common/style/app_colors.dart';
import 'package:daylog/cubits/event_list/event_list_cubit.dart';
import 'package:daylog/cubits/event_list/event_list_state.dart';
import 'package:daylog/models/event.dart';
import 'package:daylog/pages/dashboard/widgets/event_list_item.dart';
import 'package:daylog/widgets/buttons/default_app_bar_icon_button.dart';
import 'package:daylog/widgets/date_selector/date_selector_widget.dart';
import 'package:daylog/widgets/default_app_bar/default_app_bar.dart';
import 'package:daylog/widgets/scaffold/common_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  DateTime _selectedDate = DateTime.now();

  EventListCubit get _eventListCubit => context.read<EventListCubit>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _eventListCubit.loadData();
    });
  }

  void onDateUpdated(DateTime date) {
    setState(
      () => _selectedDate = date,
    );
    _eventListCubit.updateDate(date);
  }

  void onTapEvent(Event event) => context.push(
        '${AppRouter.daylog}/${event.id}',
        // AppRouter.daylogName,
        // params: <String, String>{'id': event.id ?? '-1'},
      );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventListCubit, EventListState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return CommonScaffold(
          backgroundColor: Theme.of(context).primaryColor,
          isLoading: state.isLoading,
          appBar: DefaultAppBar(
            title: 'Dashboard',
            backgroundColor: AppColors.darkRed2,
            // leading: DefaultAppBarIconButton(
            //   label: 'Create task',
            //  icon: Icons.task_alt,
            //   onTap: () => context.go(AppRouter.daylog),
            //   style: ButtonStyle(
            //     fixedSize: MaterialStateProperty.all<Size>(const Size(10, 60)),
            //     backgroundColor:
            //         MaterialStateProperty.all<Color>(AppColors.darkRed2),
            //   ),
            // ),
            actions: <Widget>[
              DefaultAppBarIconButton(
                key: const Key('SchedulerLogSaveButton'),
                icon: Icons.task_alt,
                label: 'Create task',
                onTap: () => context.push('${AppRouter.daylog}/-1'),
                style: ButtonStyle(
                  fixedSize:
                      MaterialStateProperty.all<Size>(const Size(105, 55)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(AppColors.darkRed2),
                ),
              )
            ],
          ),
          body: Column(
            children: [
              DateSelectorWidget(
                date: _selectedDate,
                onChange: onDateUpdated,
              ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(10),
                  itemCount: state.list.length,
                  itemBuilder: (_, index) {
                    final event = state.list[index];
                    return EventListItem(
                      // key: const Key('DashboardListKey'),
                      // key: ValueKey(event.id),
                      isDraft: event.id?.startsWith(Event.draftPrefix) ?? false,
                      event: event,
                      onTap: () => onTapEvent(event),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
