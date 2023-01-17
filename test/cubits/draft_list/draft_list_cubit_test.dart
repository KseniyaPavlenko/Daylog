// ignore_for_file: unused_local_variable

import 'package:daylog/cubits/draft_list/draft_list_cubit.dart';
import 'package:daylog/cubits/draft_list/draft_list_state.dart';
import 'package:daylog/services/draft/draft_service_mock.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Draft List Cubit', () {
    late DraftListCubit draftListCubit;
    setUp((() {
      draftListCubit = DraftListCubit(draftService: DraftServiceMock());
    }));

    test(
      'Get draft',
      () async {
        // Given

        // When

        // Then

        final resultDraftList = DraftServiceMock.mockedDraftList();
        const draftId = '5a1101fa-8361-40ed-9a6b-b9eda6b1595b';

        expect(draftListCubit.state, const DraftListState(isLoading: false));
        expectLater(
          draftListCubit.stream,
          emitsInOrder([
            const DraftListState(isLoading: true),
            DraftListState(isLoading: true, drafts: resultDraftList),
            DraftListState(isLoading: false, drafts: resultDraftList),
          ]),
        );

        // When
        await draftListCubit.loadData();
      },
    );

    test(
      'Delete draft',
      () async {
        // Given

        // When

        // Then
        final resultDraftList = DraftServiceMock.mockedDraftList();
        const draftId = '5a1101fa-8361-40ed-9a6b-b9eda6b1595b';
        final resultDraftListWithDeletedItem =
            resultDraftList.where((e) => e.id != draftId).toList();

        expect(draftListCubit.state, const DraftListState(isLoading: false));
        expectLater(
          draftListCubit.stream,
          emitsInOrder([
            const DraftListState(isLoading: true),
            DraftListState(isLoading: true, drafts: resultDraftList),
            DraftListState(isLoading: false, drafts: resultDraftList),
            DraftListState(isLoading: true, drafts: resultDraftList),
            DraftListState(
                isLoading: true, drafts: resultDraftListWithDeletedItem),
            DraftListState(
                isLoading: false, drafts: resultDraftListWithDeletedItem),
          ]),
        );

        // When
        await draftListCubit.loadData();
        await draftListCubit.deleteDraft(draftId);
      },
    );
  });
}
