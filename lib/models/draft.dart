import 'package:daylog/common/utils/date_utils.dart';
import 'package:daylog/models/event.dart';
import 'package:equatable/equatable.dart';

class Draft with EquatableMixin {
  final String? id;
  final String? userId;
  final DateTime? startDate;
  final DateTime? endDate;
  final DateTime? startAt;
  final int? duration;
  final int? days; // 1000011 => 64 + 3 = 67
  final String? title;
  final String? detail;

  Draft({
    this.id,
    this.userId,
    this.startDate,
    this.endDate,
    this.startAt,
    this.duration,
    this.days,
    this.title,
    this.detail,
  });

  //Draft.fromJson(Map<String, dynamic> json)  
  Draft.fromJson(Map<String, dynamic> json)  
      : id = json['id'] as String,
        userId = json['userId'] as String,
        startDate = DateTime.parse(json['startDate']),
        endDate = DateTime.parse(json['endDate']),
        startAt = DateTime.parse(json['startAt']),
        duration = json['duration'],
        days = json['days'] ,
        title = json['title'] as String,
        detail = json['detail'] as String;
  // Draft.fromJson(Map<String, dynamic> json)  
  //     : id = json['id'] ,
  //       userId = json['userId'],
  //       startDate = DateTime.parse(json['startDate']),
  //       endDate = DateTime.parse(json['endDate']),
  //       startAt = DateTime.parse(json['startAt']),
  //       duration = json['duration'],
  //       days = json['days'],
  //       title = json['title'],
  //       detail = json['detail'];

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'userId': userId,
        'startDate': startDate?.formatDate(),
        'endDate': endDate?.formatDate(),
        'startAt': startAt?.formatDateTime(),
        'duration': duration,
        'days': days,
        'title': title,
        'detail': detail,
      };

  Event get toEvent {
    return Event(
      id: Event.draftKey,
      userId: userId,
      startAt: startAt,
      startDate: startDate,
      duration: duration,
      title: title,
      detail: detail,
    );
  }

  Draft copyWith({
    String? id,
    String? userId,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? startAt,
    int? duration,
    int? days,
    String? title,
    String? detail,
  }) {
    return Draft(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      startAt: startAt ?? this.startAt,
      duration: duration ?? this.duration,
      days: days ?? this.days,
      title: title ?? this.title,
      detail: detail ?? this.detail,
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
      endDate,
      title,
      detail,
      days
    ];
  }
}
