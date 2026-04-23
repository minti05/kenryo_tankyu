//DateTime型をjsonに変換するための独自クラス
//参考元 https://zenn.dev/tokku5552/articles/json_converter_freezed
import 'package:json_annotation/json_annotation.dart';

class DateTimeConverter implements JsonConverter<DateTime, String> {
  const DateTimeConverter();

  @override
  DateTime fromJson(String json) {
    return DateTime.parse(json).toLocal();
  }

  @override
  String toJson(DateTime object) {
    return object.toIso8601String();
  }
}
