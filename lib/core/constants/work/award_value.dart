import 'package:freezed_annotation/freezed_annotation.dart';

enum AwardType {
  grand(value: 1, displayName: '大賞'),
  excellent(value: 2, displayName: '優秀賞'),
  encouragement(value: 3, displayName: '奨励賞'),
  honorable(value: 4, displayName: '入賞');

  final int value;
  final String displayName;
  const AwardType({required this.value, required this.displayName});

  static AwardType? fromValue(int? value) {
    if (value == null) return null;
    for (final type in AwardType.values) {
      if (type.value == value) return type;
    }
    return null;
  }
}

class AwardTypeConverter implements JsonConverter<AwardType?, int?> {
  const AwardTypeConverter();

  @override
  AwardType? fromJson(int? json) => AwardType.fromValue(json);

  @override
  int? toJson(AwardType? object) => object?.value;
}
