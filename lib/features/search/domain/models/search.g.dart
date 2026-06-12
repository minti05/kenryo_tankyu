// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Search _$SearchFromJson(Map<String, dynamic> json) => _Search(
      category:
          const CategoryEnumConverter().fromJson(json['category'] as String),
      subCategory: const SubCategoryEnumConverter()
          .fromJson(json['subCategory'] as String),
      enterYear: const EnterYearEnumConverter()
          .fromJson((json['enterYear'] as num).toInt()),
      eventName:
          const EventNameEnumConverter().fromJson(json['eventName'] as String),
      course: const CourseEnumConverter().fromJson(json['course'] as String),
      searchWord: json['searchWord'] == null
          ? const []
          : const SearchWordConverter().fromJson(json['searchWord'] as String),
      numberOfHits: (json['numberOfHits'] as num?)?.toInt() ?? 0,
      savedAt: _$JsonConverterFromJson<String, DateTime>(
          json['savedAt'], const DateTimeConverter().fromJson),
    );

Map<String, dynamic> _$SearchToJson(_Search instance) => <String, dynamic>{
      'category': const CategoryEnumConverter().toJson(instance.category),
      'subCategory':
          const SubCategoryEnumConverter().toJson(instance.subCategory),
      'enterYear': const EnterYearEnumConverter().toJson(instance.enterYear),
      'eventName': const EventNameEnumConverter().toJson(instance.eventName),
      'course': const CourseEnumConverter().toJson(instance.course),
      'searchWord': const SearchWordConverter().toJson(instance.searchWord),
      'numberOfHits': instance.numberOfHits,
      'savedAt': _$JsonConverterToJson<String, DateTime>(
          instance.savedAt, const DateTimeConverter().toJson),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
