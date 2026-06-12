// ignore_for_file: invalid_annotation_target

import 'package:algoliasearch/algoliasearch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import "package:kenryo_tankyu/core/constants/work/award_value.dart";
import "package:kenryo_tankyu/core/constants/work/info_value.dart";
import "package:kenryo_tankyu/core/constants/work/category_value.dart";
import "package:kenryo_tankyu/core/constants/work/sub_category_value.dart";
import 'package:kenryo_tankyu/core/utils/date_time_converter.dart';

part 'searched.freezed.dart';
part 'searched.g.dart';

///ルール
///この「Searched」型では、探究作品を検索したときのデータの保管、検索結果のfirestoreのデータの保管、ローカルDBとしてのデータの保管、ユーザーがいいねしているかどうかなど、全てを管理しています。
///ローカルDBとしての保管としても利用するので、保守がちょいめんどくさいです。
///アプリリリース後に新しいプロパティを作成する場合は、データベースの再作成させるか、追加するプロパティは全てnull許容になるように設計してください。

///includeFromJsonと、includeToJsonは、json形式のデータを作成する際に、そのプロパティを含めるかどうかを指定するもの。
///documentIDとisFavoriteは、firestoreやalgoliaのデータから取得する際には含まれていないので、includeFromJsonをfalseにしています。
///後半の方（ライク数や、authorなど）は、DBには保存しないため、includeToJsonをfalseにしています。
@freezed
abstract class Searched with _$Searched {
  @JsonSerializable(explicitToJson: true)
  const Searched._();

  /// 受賞がある場合に「KRGP:優秀賞 弱音を吐くな賞」のような表示テキストを返す。なければ null。
  String? get awardDisplayText {
    if (awardType == null) return null;
    final typeName = awardType!.displayName;
    final trimmedName = awardName?.trim();
    if (trimmedName != null && trimmedName.isNotEmpty) {
      return 'KRGP:$typeName $trimmedName';
    }
    return 'KRGP:$typeName';
  }

  const factory Searched({
    @Default(00000000) int documentID,
    @Default(false) bool isFavorite,
    @CategoryEnumConverter() required Category category1,
    @SubCategoryEnumConverter() required SubCategory subCategory1,
    @CategoryEnumConverter() required Category category2,
    @SubCategoryEnumConverter() required SubCategory subCategory2,
    @EnterYearEnumConverter() required EnterYear enterYear,
    @EventNameEnumConverter() required EventName eventName,
    @CourseEnumConverter() required Course course,
    @Default('') String title,
    @Default('') String author,
    @Default(0) int likes,
    @Default(false) bool existsSlide,
    @Default(false) bool existsReport,
    @Default(false) bool existsThesis,
    @Default(false) bool existsPoster,
    @DateTimeConverter() DateTime? savedAt,
    @Default(true) bool isCached,
    @AwardTypeConverter() AwardType? awardType,
    String? awardName,
  }) = _Searched;

  factory Searched.fromJson(Map<String, dynamic> json) =>
      _$SearchedFromJson(json);

  ///Algoliaから取得したsnapshotは、objectIDとisFavoriteのみjson形式ではないため、無理やりcopyWithで変換して付け加えている。
  factory Searched.fromAlgolia(Hit doc, bool isFavorite) {
    debugPrint(doc.toString());
    final Map<String, dynamic> data =
        doc.map((key, value) => MapEntry(key, value));
    final searched = Searched.fromJson(data);
    return searched.copyWith(
        documentID: int.parse(doc.objectID),
        isFavorite: isFavorite,
        isCached: false);
  }

  factory Searched.fromFirestore(DocumentSnapshot doc, bool isFavorite) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final searched = Searched.fromJson(data);
    return searched.copyWith(
        documentID: int.parse(doc.id), isFavorite: isFavorite, isCached: false);
  }

  factory Searched.fromSQLite(Map<String, dynamic> json) {
    final mutableJson = Map<String, dynamic>.from(json);
    //SQLiteから取得したデータは、0,1で保存されているため、bool型に変換する。
    //searchedはimmutableなので、mutableJsonを作成してから新たなインスタンスを生成している。
    mutableJson['isFavorite'] = mutableJson['isFavorite'] == 1;
    mutableJson['existsSlide'] = mutableJson['existsSlide'] == 1;
    mutableJson['existsReport'] = mutableJson['existsReport'] == 1;
    mutableJson['existsThesis'] = mutableJson['existsThesis'] == 1;
    mutableJson['existsPoster'] = mutableJson['existsPoster'] == 1;
    return Searched.fromJson(mutableJson);
  }

  Map<String, dynamic> toSQLite() {
    final json = this.toJson();
    json.remove('isCached');
    json['isFavorite'] = this.isFavorite ? 1 : 0;
    json['existsSlide'] = this.existsSlide ? 1 : 0;
    json['existsReport'] = this.existsReport ? 1 : 0;
    json['existsThesis'] = this.existsThesis ? 1 : 0;
    json['existsPoster'] = this.existsPoster ? 1 : 0;
    json['savedAt'] = DateTime.now().toIso8601String();
    return json;
  }

  /// Supabase の browsing_history テーブル用（user_id・viewed_at は含まない）
  Map<String, dynamic> toSupabase() {
    return {
      'document_id': documentID,
      'title': title,
      'author': author,
      'category1': const CategoryEnumConverter().toJson(category1),
      'sub_category1': const SubCategoryEnumConverter().toJson(subCategory1),
      'category2': const CategoryEnumConverter().toJson(category2),
      'sub_category2': const SubCategoryEnumConverter().toJson(subCategory2),
      'enter_year': const EnterYearEnumConverter().toJson(enterYear),
      'event_name': const EventNameEnumConverter().toJson(eventName),
      'course': const CourseEnumConverter().toJson(course),
      'likes': likes,
      'exists_slide': existsSlide,
      'exists_report': existsReport,
      'exists_thesis': existsThesis,
      'exists_poster': existsPoster,
      'award_type': const AwardTypeConverter().toJson(awardType),
      'award_name': awardName,
    };
  }

  factory Searched.fromSupabase(Map<String, dynamic> row,
      {bool isFavorite = false}) {
    return Searched(
      documentID: row['document_id'] as int,
      isFavorite: isFavorite,
      category1:
          const CategoryEnumConverter().fromJson(row['category1'] as String),
      subCategory1: const SubCategoryEnumConverter()
          .fromJson(row['sub_category1'] as String),
      category2:
          const CategoryEnumConverter().fromJson(row['category2'] as String),
      subCategory2: const SubCategoryEnumConverter()
          .fromJson(row['sub_category2'] as String),
      enterYear:
          const EnterYearEnumConverter().fromJson(row['enter_year'] as int),
      eventName:
          const EventNameEnumConverter().fromJson(row['event_name'] as String),
      course: const CourseEnumConverter().fromJson(row['course'] as String),
      title: row['title'] as String,
      author: row['author'] as String,
      likes: row['likes'] as int,
      existsSlide: row['exists_slide'] as bool,
      existsReport: row['exists_report'] as bool,
      existsThesis: row['exists_thesis'] as bool,
      existsPoster: row['exists_poster'] as bool,
      savedAt: DateTime.parse(row['viewed_at'] as String).toLocal(),
      isCached: true,
      awardType: AwardType.fromValue(row['award_type'] as int?),
      awardName: row['award_name'] as String?,
    );
  }
}
