// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_stats.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserStats _$UserStatsFromJson(Map<String, dynamic> json) => _UserStats(
      todayViews: (json['todayViews'] as num).toInt(),
      weekViews: (json['weekViews'] as num).toInt(),
      totalViews: (json['totalViews'] as num).toInt(),
      streakDays: (json['streakDays'] as num).toInt(),
    );

Map<String, dynamic> _$UserStatsToJson(_UserStats instance) =>
    <String, dynamic>{
      'todayViews': instance.todayViews,
      'weekViews': instance.weekViews,
      'totalViews': instance.totalViews,
      'streakDays': instance.streakDays,
    };
