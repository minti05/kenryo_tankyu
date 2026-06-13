import 'package:kenryo_tankyu/core/constants/work/award_value.dart';
import 'package:kenryo_tankyu/core/constants/work/info_value.dart';
import 'package:kenryo_tankyu/features/krgp/data/datasources/krgp_remote_data_source.dart';
import 'package:kenryo_tankyu/features/research_work/domain/models/searched.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'krgp_provider.g.dart';

enum KrgpSortMode { year, award }

/// Firestoreから全KRGP受賞作品を1度だけ取得してキャッシュする
@Riverpod(keepAlive: true)
Future<List<Searched>> krgpAwards(Ref ref) async {
  final dataSource = ref.watch(krgpRemoteDataSourceProvider);
  return dataSource.fetchAllAwards();
}

/// year モード: enterYear → [awardType → [awardName → works]]
Map<EnterYear, Map<AwardType, Map<String?, List<Searched>>>> groupByYear(
    List<Searched> works) {
  final result = <EnterYear, Map<AwardType, Map<String?, List<Searched>>>>{};

  for (final work in works) {
    final year = work.enterYear;
    if (year == EnterYear.undefined) continue;

    final type = work.awardType;
    if (type == null) continue;

    final nameKey =
        work.awardName?.trim().isEmpty ?? true ? null : work.awardName?.trim();

    result
        .putIfAbsent(year, () => {})
        .putIfAbsent(type, () => {})
        .putIfAbsent(nameKey, () => [])
        .add(work);
  }

  return result;
}

/// award モード: awardType → [awardName → [enterYear → works]]
Map<AwardType, Map<String?, Map<EnterYear, List<Searched>>>> groupByAward(
    List<Searched> works) {
  final result = <AwardType, Map<String?, Map<EnterYear, List<Searched>>>>{};

  for (final work in works) {
    final type = work.awardType;
    if (type == null) continue;

    final nameKey =
        work.awardName?.trim().isEmpty ?? true ? null : work.awardName?.trim();

    result
        .putIfAbsent(type, () => {})
        .putIfAbsent(nameKey, () => {})
        .putIfAbsent(work.enterYear, () => [])
        .add(work);
  }

  return result;
}
