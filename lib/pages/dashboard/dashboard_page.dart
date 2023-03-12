import 'package:daylog/cubits/event_list/event_list_cubit.dart';
import 'package:daylog/cubits/event_list/event_list_state.dart';
import 'package:daylog/models/event.dart';
import 'package:daylog/pages/dashboard/widgets/event_list_item.dart';
import 'package:daylog/widgets/date_selector/date_selector_widget.dart';
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
  DateTime selectedDate =
      DateTime.now(); // TODO(Kseniya): должно быть private _selectedDate
  String text =
      "Daylog"; // TODO(Kseniya): должно быть private, зачем это вообще :)
  EventListCubit get eventListCubit => // TODO(Kseniya): должно быть private
      context.read<
          EventListCubit>(); // TODO(Kseniya): разделяй геттеры и переменные пустой строкой

  @override
  void initState() {
    super.initState();
    // TODO(Kseniya): оберни в post frame callback
    eventListCubit.loadData();
  }

  void onDateUpdated(DateTime date) {
    setState(() {
      selectedDate = date; // TODO(Kseniya): переделай в стрелочную функцию
    });
    eventListCubit.updateDate(date);
  }

  /* TODO(Kseniya): Используей GoRouter 
  + путь используй из константы, возможно нужно передачу id переделать под extra как в SchedulerLogPage */
  void onTapEvent(Event event) => context.push('/daylog/${event.id}');

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
          appBar: AppBar(
            backgroundColor:
                const Color(0xFF3E2723), // TODO(Kseniya): вынеси в AppColors
            title: const Text('Dashboard'),
          ),
          // error: state.error?message, // TODO(Kseniya): удали
          body:
              // TODO(Kseniya): удали
              // backgroundColor: Theme.of(context).primaryColor,
              // appBar: AppBar(
              //   backgroundColor: const Color(0xFF3E2723),
              //   title: const Text('Dashboard'),
              // ),
              // body: BlocBuilder<EventListCubit, EventListState>(
              //   builder: (context, state) {
              //     if (state.isLoading) {
              //       return const Center(child: CircularProgressIndicator());
              //     }
              //return
              Column(
            children: [
              DateSelectorWidget(
                date: selectedDate,
                onChange: onDateUpdated,
              ),
              Expanded(
                child: Container(
                  // color: Colors.grey[600],  // TODO(Kseniya): удали
                  // TODO(Kseniya): у ListView тоже есть padding, container не нужен
                  padding: const EdgeInsets.all(10),
                  child: ListView.separated(
                    itemCount: state.list.length,
                    itemBuilder: (_, index) {
                      final event = state.list[index];
                      return EventListItem(
                        isDraft: event.id == Event.draftKey,
                        event: event,
                        onTap: () => onTapEvent(event),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

 // TODO(Kseniya): удали 
//  return Center(
//               child: Container(
//                 padding: const EdgeInsets.only(top: 30),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Text(
//                       '${initialDate.year}.${initialDate.month}.${initialDate.day}',
//                       style: const TextStyle(fontSize: 26),
//                     ),
//                     const SizedBox(height: 13),
//                     ElevatedButton(
//                       child: const Text(
//                         'Select date',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                       onPressed: () async {
//                         DateTime? newDate = await showDatePicker(
//                             context: context,
//                             initialDate: initialDate,
//                             firstDate: DateTime(2015),
//                             lastDate: DateTime(2025));

//                         if (newDate == null) return;
//                         setState(() => initialDate = newDate);
//                       },
//                     ),
//                     Button(text)
//                     //_button(text, () {})
//                   ],
//                 ),
//               ),
//             );
