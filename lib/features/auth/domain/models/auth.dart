
import 'package:freezed_annotation/freezed_annotation.dart';
import "package:kenryo_tankyu/core/constants/feature/user_value.dart";

part 'auth.freezed.dart';

part 'auth.g.dart';

@freezed
abstract class Auth with _$Auth {
  const factory Auth({
    @AffiliationConverter() Affiliation? affiliation,
    String? email,
    String? password,
    String? userName,
    @Default(false) bool confirmVerifyEmail,
    @Default(5)int limit,
  }) = _Auth;
  factory Auth.fromJson(Map<String, dynamic> json) => _$AuthFromJson(json);
}

class AffiliationConverter implements JsonConverter<Affiliation,String> {
  const AffiliationConverter();

  @override
  Affiliation fromJson(String json) {
    return Affiliation.values.firstWhere((e) => e.toString() == json);
  }

  @override
  String toJson(Affiliation object) {
    return object.toString();
  }
}