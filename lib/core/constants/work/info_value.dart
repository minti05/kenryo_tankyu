import 'package:freezed_annotation/freezed_annotation.dart';

enum EnterYear {
  enter2020(displayName: 2020),
  enter2021(displayName: 2021),
  enter2022(displayName: 2022),
  enter2023(displayName: 2023),
  enter2024(displayName: 2024),
  enter2025(displayName: 2025),
  undefined(displayName: 0);

  final int displayName;
  const EnterYear({required this.displayName});

  String get label {
    if (this == EnterYear.undefined) return '指定なし';
    return '$displayName年度入学';
  }
}

class EnterYearEnumConverter implements JsonConverter<EnterYear, int> {
  const EnterYearEnumConverter();
  @override
  EnterYear fromJson(int json) {
    final EnterYear enterYear = EnterYear.values.firstWhere(
        (element) => element.displayName == json,
        orElse: () => EnterYear.undefined);
    return enterYear;
  }

  @override
  int toJson(EnterYear object) => object.displayName;
}

class IntBoolConverter implements JsonConverter<bool, int> {
  const IntBoolConverter();
  @override
  bool fromJson(int json) {
    return json == 1;
  }

  @override
  int toJson(bool object) => object ? 1 : 0;
}

enum DocumentType {
  slide,
  report,
  poster,
  thesis,
}

extension DocumentTypeExtension on DocumentType {
  String get displayName {
    switch (this) {
      case DocumentType.slide:
        return 'スライド';
      case DocumentType.report:
        return 'レポート';
      case DocumentType.poster:
        return 'ポスター';
      case DocumentType.thesis:
        return '論文';
    }
  }

  String get idSuffix {
    switch (this) {
      case DocumentType.slide:
        return '1';
      case DocumentType.report:
        return '2';
      case DocumentType.poster:
        return '3';
      case DocumentType.thesis:
        return '4';
    }
  }
}

enum EventName {
  localLearning(displayName: '信州学'),
  individualTankyu(displayName: '個人探究'),
  undefined(displayName: '指定なし');

  final String displayName;

  const EventName({required this.displayName});
}

class EventNameEnumConverter implements JsonConverter<EventName, String> {
  const EventNameEnumConverter();

  @override
  EventName fromJson(String json) {
    final EventName eventName = EventName.values.firstWhere(
        (element) => element.name == json,
        orElse: () => EventName.undefined);
    return eventName;
  }

  @override
  String toJson(EventName object) => object.name;
}

enum Course {
  tankyu(displayName: '探究科'),
  general(displayName: '普通科'),
  undefined(displayName: '指定なし');

  final String displayName;
  const Course({required this.displayName});
}

class CourseEnumConverter implements JsonConverter<Course, String> {
  const CourseEnumConverter();

  @override
  Course fromJson(String json) {
    final Course course = Course.values.firstWhere(
        (element) => element.name == json,
        orElse: () => Course.undefined);
    return course;
  }

  @override
  String toJson(Course object) => object.name;
}
