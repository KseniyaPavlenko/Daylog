import 'package:equatable/equatable.dart';

import '../common/utils/date_utils.dart';

class Event with EquatableMixin {
  final String? id;
  final String? userId;
  final String? draftId;
  // final DateTime? updateAt;
  final DateTime? startAt;
  final DateTime? startDate;
  final int? duration;
  final EventStatus? status;
  final String? title;
  final String? detail;
  final String? comment;
  //
  static const draftKey = 'draftKey';

  Event({
    this.id,
    this.userId,
    this.draftId,
    // this.updateAt,
    this.startAt,
    this.startDate,
    this.duration,
    this.status,
    this.title,
    this.detail,
    this.comment,
  });

  Event.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        userId = json['userId'],
        draftId = json['draftId'],
        // updateAt = DateTime.parse(json['updateAt']),
        startAt = DateTime.parse(json['startAt']),
        startDate = DateTime.parse(json['startDate']),
        duration = json['duration'],
        status = EventStatus.parse(json['status']),
        title = json['title'],
        detail = json['detail'],
        comment = json['comment'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'draftId': draftId,
        // 'updateAt': updateAt?.formatDateTime(),
        'startAt': startAt?.formatDateTime(),
        'startDate': startDate?.formatDate(),
        'duration': duration,
        'status': status?.name,
        'title': title,
        'detail': detail,
        'comment': comment,
      };

  Event copyWith({
    String? id,
    String? userId,
    String? draftId,
    DateTime? startAt,
    DateTime? startDate,
    int? duration,
    EventStatus? status,
    String? title,
    String? detail,
    String? comment,
  }) {
    return Event(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      draftId: draftId ?? this.draftId,
      startAt: startAt ?? this.startAt,
      startDate: startDate ?? this.startDate,
      duration: duration ?? this.duration,
      status: status ?? this.status,
      title: title ?? this.title,
      detail: detail ?? this.detail,
      comment: comment ?? this.comment,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      userId,
      draftId,
      startAt,
      startDate,
      duration,
      status,
      title,
      detail,
      comment
    ];
  }
}

enum EventStatus {
  todo,
  progress,
  done;

  static EventStatus parse(String? value) {
    return values.firstWhere((e) => e.name == value,
        orElse: () => EventStatus.todo);
  }

  String get label {
    switch (this) {
      case EventStatus.todo:
        return 'TODO';
      case EventStatus.progress:
        return 'In Progress';
      case EventStatus.done:
        return 'Done';
    }
  }
}

extension EventStatusX on EventStatus {}
