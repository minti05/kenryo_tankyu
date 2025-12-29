import 'dart:convert';
import 'package:kenryo_tankyu/features/research_work/domain/models/searched.dart';
import 'package:kenryo_tankyu/core/providers/shared_preferences_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'recommended_works_local_data_source.g.dart';

@Riverpod(keepAlive: true)
RecommendedWorksLocalDataSource recommendedWorksLocalDataSource(Ref ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return RecommendedWorksLocalDataSource(prefs);
}

class RecommendedWorksLocalDataSource {
  final SharedPreferences _prefs;

  RecommendedWorksLocalDataSource(this._prefs);

  Future<void> save(Searched searched1, Searched searched2) async {
    final json1 = jsonEncode(searched1.toSQLite());
    final json2 = jsonEncode(searched2.toSQLite());

    _prefs.setString('searched1', json1);
    _prefs.setString('searched2', json2);
  }

  Future<List<Searched>> load() async {
    final json1 = _prefs.getString('searched1');
    final json2 = _prefs.getString('searched2');
    if (json1 == null || json2 == null) {
      return [];
    }
    final searched1 = Searched.fromSQLite(jsonDecode(json1));
    final searched2 = Searched.fromSQLite(jsonDecode(json2));

    return [searched1, searched2];
  }
}
