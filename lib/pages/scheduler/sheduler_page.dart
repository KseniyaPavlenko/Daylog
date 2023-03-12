import 'package:daylog/common/route/router.dart';
import 'package:daylog/common/style/app_colors.dart';
import 'package:daylog/cubits/draft_list/draft_list_cubit.dart';
import 'package:daylog/cubits/draft_list/draft_list_state.dart';
import 'package:daylog/models/draft.dart';
import 'package:daylog/pages/scheduler/widgets/draft_list_item.dart';
import 'package:daylog/widgets/scaffold/common_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SchedulerPage extends StatefulWidget {
  const SchedulerPage({Key? key}) : super(key: key);

  @override
  State<SchedulerPage> createState() => _SchedulerPageState();
}

class _SchedulerPageState extends State<SchedulerPage> {
  DraftListCubit get _draftListCubit => context.read<DraftListCubit>();
  List<Draft>? get _currentDraftList => _draftListCubit.state.drafts;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _draftListCubit.loadData();
    });
  }

  void onTapDraft(Draft draft) => context.push(
        AppRouter.schedulerLog,
        extra: draft.id,
      );

  @override
  Widget build(BuildContext context) => CommonScaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          title: const Text('Scheduler'),
          backgroundColor: AppColors.darkRed2,
        ),
        body: BlocBuilder<DraftListCubit, DraftListState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return Column(
              children: [
                Expanded(
                  child: Container(
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
}
