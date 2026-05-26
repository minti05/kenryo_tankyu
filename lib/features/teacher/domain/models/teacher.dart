import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'teacher.freezed.dart';
part 'teacher.g.dart';

@freezed
@freezed
abstract class Teacher with _$Teacher {
  const factory Teacher({
    required String id,
    required String name,
    required String nameKana,
    @SubjectEnumConverter() @Default(SubjectType.other) SubjectType subject,
    @GradeInChargeEnumConverter()
    @Default(GradeInCharge.unknown)
    GradeInCharge gradeInCharge,
    required String filename,
    @Default([]) List<String> keywords,
  }) = _Teacher;

  factory Teacher.empty() => Teacher(
        id: '',
        name: '',
        nameKana: '',
        subject: SubjectType.other,
        gradeInCharge: GradeInCharge.unknown,
        filename: '',
        keywords: [],
      );

  factory Teacher.fromJson(Map<String, dynamic> json) =>
      _$TeacherFromJson(json);
}

class SubjectEnumConverter implements JsonConverter<SubjectType, String> {
  const SubjectEnumConverter();

  @override
  SubjectType fromJson(String json) => SubjectType.values.byName(json);

  @override
  String toJson(SubjectType object) => object.name;
}

enum SubjectType {
  japanese(name: '国語', color: Colors.red),
  math(name: '数学', color: Colors.blue),
  science(name: '理科', color: Colors.green),
  social(name: '社会', color: Colors.orange),
  english(name: '英語', color: Colors.purple),
  art(name: '芸術', color: Colors.yellow),
  pe(name: '体育', color: Colors.pink),
  home(name: '家庭科', color: Colors.brown),
  information(name: '情報', color: Colors.teal),
  tankyu(name: '探究', color: Colors.grey),
  office(name: '事務', color: Colors.black),
  kotyo(name: '校長', color: Colors.grey),
  kyoto(name: '教頭', color: Colors.grey),
  other(name: 'その他', color: Colors.grey);

  final String name;
  final Color color;
  const SubjectType({required this.name, required this.color});
}

class GradeInChargeEnumConverter
    implements JsonConverter<GradeInCharge, String> {
  const GradeInChargeEnumConverter();

  @override
  GradeInCharge fromJson(String json) => GradeInCharge.values.byName(json);

  @override
  String toJson(GradeInCharge object) => object.name;
}

enum GradeInCharge {
  first(name: '1年生', color: Colors.red),
  second(name: '2年生', color: Colors.blue),
  third(name: '3年生', color: Colors.green),
  other(name: 'その他', color: Colors.grey),
  unknown(name: '不明', color: Colors.black);

  final String name;
  final Color color;
  const GradeInCharge({required this.name, required this.color});
}
