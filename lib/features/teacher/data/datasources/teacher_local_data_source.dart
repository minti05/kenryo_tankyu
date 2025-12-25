import 'package:kenryo_tankyu/core/providers/shared_preferences_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'teacher_local_data_source.g.dart';

abstract class TeacherLocalDataSource {
  String? getCachedTeachers();
  Future<void> cacheTeachers(String jsonString);
}

class TeacherLocalDataSourceImpl implements TeacherLocalDataSource {
  TeacherLocalDataSourceImpl(this._prefs);
  final SharedPreferences _prefs;
  static const _key = 'teacherData';

  @override
  String? getCachedTeachers() {
    return _prefs.getString(_key);
  }

  @override
  Future<void> cacheTeachers(String jsonString) async {
    await _prefs.setString(_key, jsonString);
  }
}

@riverpod
TeacherLocalDataSource teacherLocalDataSource(Ref ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return TeacherLocalDataSourceImpl(prefs);
}
