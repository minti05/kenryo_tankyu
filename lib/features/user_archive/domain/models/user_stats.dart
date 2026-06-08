import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_stats.freezed.dart';
part 'user_stats.g.dart';

@freezed
abstract class UserStats with _$UserStats {
  const factory UserStats({
    required int todayViews,
    required int weekViews,
    required int totalViews,
    required int streakDays,
  }) = _UserStats;

  factory UserStats.fromJson(Map<String, dynamic> json) =>
      _$UserStatsFromJson(json);
}
