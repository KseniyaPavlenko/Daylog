import 'package:daylog/cubits/event_list/event_list_cubit.dart';
import 'package:daylog/cubits/event_list/event_list_state.dart';
import 'package:daylog/models/event.dart';
import 'package:daylog/pages/dashboard/widgets/event_list_item.dart';
import 'package:daylog/widgets/date_selector/date_selector_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  DateTime selectedDate = DateTime.now();
  String text = "Daylog";
  EventListCubit get eventListCubit => context.read<EventListCubit>();

  @override
  void initState() {
    super.initState();
    eventListCubit.loadData();
  }

  void setDate() => eventListCubit.updateDate(selectedDate);

  void onLeftTap() {
    setState(() {
      selectedDate = selectedDate.subtract(const Duration(days: 1));
    });
    setDate();
  }

  void onRightTap() {
    setState(() {
      selectedDate = selectedDate.add(const Duration(days: 1));
    });
    setDate();
  }

  void onTapEvent(Event event) => context.push('/daylog/${event.id}');

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          backgroundColor: Colors.brown[900],
          title: const Text('Dashboard'),
        ),
        body: BlocBuilder<EventListCubit, EventListState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Column(
              children: [
                DateSelectorWidget(
                  date: selectedDate,
                  onLeftTap: onLeftTap,
                  onRightTap: onRightTap,
                ),
                Expanded(
                  child: Container(
                    // color: Colors.grey[600],
                    padding: const EdgeInsets.all(10),
                    child: ListView.separated(
                      itemCount: state.list.length,
                      itemBuilder: (_, index) {
                        final event = state.list[index];
                        return EventListItem(
                          event: event,
                          onTap: () => onTapEvent(event),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      );
}

//TODO: 
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
