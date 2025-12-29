// ignore_for_file: invalid_annotation_target

import 'dart:convert';

import "package:kenryo_tankyu/core/constants/work/info_value.dart";
import "package:kenryo_tankyu/core/constants/work/category_value.dart";
import "package:kenryo_tankyu/core/constants/work/sub_category_value.dart";
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kenryo_tankyu/core/utils/date_time_converter.dart';

part 'search.freezed.dart';
part 'search.g.dart';
//ファイルが生成されなくてキレそうな時は…。笑
//①'search.g.dart'を書き直す
//②pabspec.lockファイルを消去
//③.freezedファイルと.gファイルを消去
//④flutter clean
//⑤アプリ再起動
//⑥flutter pub get
//⑦flutter pub run build_runner build --delete-conflicting-outputs

@freezed
abstract class Search with _$Search {
  @JsonSerializable(explicitToJson: true)
  const Search._();

  const factory Search({
    @CategoryEnumConverter() required Category category,
    @SubCategoryEnumConverter() required SubCategory subCategory,
    @EnterYearEnumConverter() required EnterYear enterYear,
    @EventNameEnumConverter() required EventName eventName,
    @CourseEnumConverter() required Course course,
    @SearchWordConverter() @Default([]) List<String> searchWord,
    @Default(0) int numberOfHits,
    @DateTimeConverter() DateTime? savedAt,
  }) = _Search;

  factory Search.fromJson(Map<String, dynamic> json) => _$SearchFromJson(json);
}

class SearchWordConverter implements JsonConverter<List<String>, String> {
  const SearchWordConverter();

  @override
  List<String> fromJson(String json) {
    List<dynamic> decodedJson = jsonDecode(json);
    return decodedJson.map((e) => e.toString()).toList();
  }

  @override
  String toJson(List<dynamic> object) {
    return jsonEncode(object);
  }
}
