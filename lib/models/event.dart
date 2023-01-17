import 'package:equatable/equatable.dart';

import '../common/utils/date_utils.dart';

class Event with EquatableMixin {
  final String? id;
  final String? userId;
  // final DateTime? updateAt;
  final DateTime? startAt;
  final DateTime? startDate;
  final int? duration;
  final EventStatus? status;
  final String? title;
  final String? detail;
  final String? comment;

  Event({
    this.id,
    this.userId,
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
}

extension EventStatusX on EventStatus {}
