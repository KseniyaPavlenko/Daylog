import 'package:daylog/models/draft.dart';
import 'package:equatable/equatable.dart';

class DraftDetailState with EquatableMixin {
  final bool isLoading;
  final bool isNew;
  final Draft? selectedDraft;

  const DraftDetailState({
    this.isLoading = false,
    this.selectedDraft,
    this.isNew = false,
  });

  DraftDetailState copyWith({
    bool? isLoading,
    bool? isNew,
    Draft? selectedDraft,
  }) {
    return DraftDetailState(
      isLoading: isLoading ?? this.isLoading,
      isNew: isNew ?? this.isNew,
      selectedDraft: selectedDraft ?? this.selectedDraft,
    );
  }

  factory DraftDetailState.init() {
    return const DraftDetailState(isLoading: false);
  }

  @override
  List<Object?> get props {
    return [isLoading, isNew, selectedDraft];
  }
}
