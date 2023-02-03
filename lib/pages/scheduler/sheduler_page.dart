import 'package:daylog/cubits/draft_list/draft_list_cubit.dart';
import 'package:daylog/cubits/draft_list/draft_list_state.dart';
import 'package:daylog/models/draft.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SchedulerPage extends StatefulWidget {
  const SchedulerPage({Key? key}) : super(key: key);

  @override
  State<SchedulerPage> createState() => _SchedulerPageState();
}

class _SchedulerPageState extends State<SchedulerPage> {
  DraftListCubit get draftListCubit => context.read<DraftListCubit>();
  List<Draft>? get currentDraftList => draftListCubit.state.drafts;

  @override
  void initState() {
    super.initState();
    draftListCubit.loadData();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Scheduler'),
        ),
        body: BlocBuilder<DraftListCubit, DraftListState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Column(
              children: [
                // const DateSelectorWidget(),
                Expanded(
                  child: Container(
                    color: Colors.grey[600],
                    padding: const EdgeInsets.all(10),
                    child: ListView.builder(
                      itemCount: state.drafts?.length ?? 0,
                      itemBuilder: _buildListItem,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      );
  Widget _buildListItem(BuildContext context, int index) {
    final event = currentDraftList![index];
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
