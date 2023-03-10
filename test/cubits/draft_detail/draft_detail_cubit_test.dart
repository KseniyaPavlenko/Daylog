import 'package:daylog/cubits/draft_detail/draft_detail_cubit.dart';
import 'package:daylog/cubits/draft_detail/draft_detail_state.dart';
import 'package:daylog/cubits/error_cubit/error_cubit.dart';
import 'package:daylog/models/draft.dart';
import 'package:daylog/services/draft/draft_service_mock.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Draft Detail Cubit', () {
    late DraftDetailCubit draftDetailCubit;
    setUp((() {
      draftDetailCubit = DraftDetailCubit(
        draftService: DraftServiceMock(),
        errorCubit: ErrorCubit(),
      );
    }));

    test(
      'Get draft',
      () async {
        // Given

        // When

        // Then

        // id = Draft(userId: '19dea3dd-eba9-473d-95ff-80e6ee00a710', startDate: '2022-07-03', endDate: '2022-08-03', startAt:'2022-07-03 19:10:25', duration: '60', days: '0', title: 'Task', detail: 'detail');
        // Draft draft = Draft(id: '5a1101fa-8361-40ed-9a6b-b9eda6b1595b');

        expect(
            draftDetailCubit.state, const DraftDetailState(isLoading: false));
        expectLater(
          draftDetailCubit.stream,
          emitsInOrder([
            const DraftDetailState(isLoading: true),
            DraftDetailState(
                isLoading: true,
                isNew: false,
                selectedDraft: DraftServiceMock.mockDraft1()),
            DraftDetailState(
                isLoading: false,
                isNew: false,
                selectedDraft: DraftServiceMock.mockDraft1()),
          ]),
        );

        // When
        await draftDetailCubit.loadData(DraftServiceMock.draftId1);
        // expectLater(
        //     meCubit.state, const MeState(isLoading: false, user: expectUser));

        /*  expect(draftDetailCubit.state,
          const DraftDetailState(isLoading: false, user: expectUser)); */
      },
    );

    test('UpdateDraft', () async {
      // Given

      // When

      // Then
      Draft draft = Draft(id: '5a1101fa-8361-40ed-9a6b-b9eda6b1595b');

      expect(draftDetailCubit.state, const DraftDetailState(isLoading: false));
      expectLater(
        draftDetailCubit.stream,
        emitsInOrder([
          const DraftDetailState(
              isLoading: false, isNew: true, selectedDraft: null),
          // const DraftDetailState(isLoading: true, isNew: true),
          // DraftDetailState(
          //     isLoading: true,
          //     isNew: false,
          //     selectedDraft: draft), //selectedDraft: draft),
          // DraftDetailState(
          //     isLoading: false, isNew: false, selectedDraft: draft),
        ]),
      );

      // When
      await draftDetailCubit.loadData(null);
      await draftDetailCubit.updateDraft(draft);

      expect(draftDetailCubit.state.selectedDraft, isA<Draft>());
      // expect(draftDetailCubit.state.selectedDraft.days, isA<DateTime>());
    });
  });
}
