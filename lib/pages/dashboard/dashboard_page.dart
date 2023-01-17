import 'package:daylog/cubits/event_list/event_list_cubit.dart';
import 'package:daylog/cubits/event_list/event_list_state.dart';
import 'package:daylog/models/event.dart';
import 'package:daylog/widgets/date_selector/date_selector_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  DateTime initialDate = DateTime.now();
  String text = "Daylog";
  EventListCubit get eventListCubit => context.read<EventListCubit>();
  List<Event>? get currentEventList => eventListCubit.state.events;

  @override
  void initState() {
    super.initState();
    eventListCubit.loadData();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
        ),
        body: BlocBuilder<EventListCubit, EventListState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Column(
              children: [
                const DateSelectorWidget(),
                Expanded(
                  child: Container(
                    color: Colors.grey[600],
                    padding: const EdgeInsets.all(10),
                    child: ListView.builder(
                      itemBuilder: _buildListItem,
                      itemCount: state.events?.length ?? 0,
                    ),
                  ),
                ),
              ],
            );
            /* return Center(
              child: Container(
                padding: const EdgeInsets.only(top: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '${initialDate.year}.${initialDate.month}.${initialDate.day}',
                      style: const TextStyle(fontSize: 26),
                    ),
                    const SizedBox(height: 13),
                    ElevatedButton(
                      child: const Text(
                        'Select date',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        DateTime? newDate = await showDatePicker(
                            context: context,
                            initialDate: initialDate,
                            firstDate: DateTime(2015),
                            lastDate: DateTime(2024));

                        if (newDate == null) return;
                        setState(() => initialDate = newDate);
                      },
                    ),
                    Button(text)
                    //_button(text, () {})
                  ],
                ),
              ),
            ); */
          },
        ),
      );

  Widget _buildListItem(BuildContext context, int index) {
    final event = currentEventList![index];
    return Card(
      //elevation: 20,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey[800],
        ),
        child: ListTile(
          leading: const Icon(
            Icons.add_alert,
            size: 30,
          ),
          title: Text(event.title ?? ''),
          subtitle: const Text('test subtitle'),
          trailing: const Icon(Icons.arrow_forward_ios),
          contentPadding: const EdgeInsets.all(10),
          enabled: true,
          iconColor: Colors.white,
          textColor: Colors.white,
          tileColor: Colors.grey[600],
          //// shape:
          //    RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        ),
      ),
    );
  }
}
