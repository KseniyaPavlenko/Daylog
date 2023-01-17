import 'package:daylog/models/draft.dart';
import 'package:equatable/equatable.dart';

class DraftListState with EquatableMixin {
  final bool isLoading;
  final List<Draft>? drafts;

  const DraftListState({
    this.isLoading = false,
    this.drafts,
  });

  DraftListState copyWith({
    bool? isLoading,
    List<Draft>? drafts,
  }) {
    return DraftListState(
      isLoading: isLoading ?? this.isLoading,
      drafts: drafts ?? this.drafts,
    );
  }

  factory DraftListState.init() {
    return const DraftListState(isLoading: false);
  }

  @override
  List<Object?> get props {
    return [isLoading, drafts];
  }
}
