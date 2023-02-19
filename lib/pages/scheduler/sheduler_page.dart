import 'package:daylog/common/route/router.dart';
import 'package:daylog/cubits/draft_list/draft_list_cubit.dart';
import 'package:daylog/cubits/draft_list/draft_list_state.dart';
import 'package:daylog/models/draft.dart';
import 'package:daylog/pages/scheduler/widgets/draft_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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

  void onTapDraft(Draft draft) => context.push(
        AppRouter.schedulerLog,
        extra: draft.id,
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          title: const Text('Scheduler'),
          backgroundColor: Theme.of(context).primaryColor,
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
                    //color: Colors.grey[600],
                    padding: const EdgeInsets.all(10),

                    child: ListView.separated(
                      itemCount: state.list.length,
                      itemBuilder: (_, index) {
                        final draft = state.list[index];
                        return DraftListItem(
                          draft: draft,
                          onTap: () => onTapDraft(draft),
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
  // Widget _buildListItem(BuildContext context, int index) {
  //   final event = currentDraftList![index];
  //   return Container(
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(20),
  //       color: Colors.grey[800],
  //     ),
  //     child: ListTile(
  //       leading: const Icon(
  //         Icons.add_alert,
  //         size: 30,
  //       ),
  //       title: Text(event.title ?? ''),
  //       subtitle: const Text('test subtitle'),
  //       trailing: const Icon(Icons.arrow_forward_ios),
  //       contentPadding: const EdgeInsets.all(10),
  //       enabled: true,
  //       iconColor: Colors.white,
  //       textColor: Colors.white,
  //       tileColor: Colors.grey[600],
  //       //// shape:
  //       //    RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
  //     ),
  //   );
  // }
}
