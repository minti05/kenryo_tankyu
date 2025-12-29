import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:kenryo_tankyu/core/error/error_mapper.dart';
import 'package:kenryo_tankyu/features/teacher/data/datasources/teacher_local_data_source.dart';
import 'package:kenryo_tankyu/features/teacher/data/datasources/teacher_remote_data_source.dart';
import 'package:kenryo_tankyu/features/teacher/domain/models/teacher.dart';
import 'package:kenryo_tankyu/features/teacher/domain/repositories/teacher_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'teacher_repository_impl.g.dart';

class TeacherRepositoryImpl with ErrorMapper implements TeacherRepository {
  TeacherRepositoryImpl(this._localDataSource, this._remoteDataSource);

  final TeacherLocalDataSource _localDataSource;
  final TeacherRemoteDataSource _remoteDataSource;

  @override
  Future<List<Teacher>> getTeachers() async {
    try {
      final cachedData = _localDataSource.getCachedTeachers();
      final DateTime currentDate = DateTime.now();

      if (cachedData != null) {
        final Map<String, dynamic> cachedMap = jsonDecode(cachedData);
        final DateTime lastViewed = DateTime.parse(cachedMap['lastViewed']);

        if (currentDate.month != lastViewed.month ||
            currentDate.year != lastViewed.year) {
          debugPrint("月が変わっているためサーバーからデータを取得します");
          final data = await _fetchAndCache();
          return _parseTeacherList(data);
        }

        debugPrint("キャッシュデータを更新して返します");
        cachedMap['lastViewed'] = currentDate.toIso8601String();
        await _localDataSource.cacheTeachers(jsonEncode(cachedMap));
        return _parseTeacherList(cachedMap);
      } else {
        debugPrint("キャッシュデータがないためサーバーからデータを取得します");
        final data = await _fetchAndCache();
        return _parseTeacherList(data);
      }
    } catch (e) {
      throw mapException(e);
    }
  }

  Future<Map<String, dynamic>> _fetchAndCache() async {
    final data = await _remoteDataSource.fetchTeachers();
    final map = {
      'teachers': data['teachers'],
      'lastViewed': DateTime.now().toIso8601String(),
      'madeAt': (data['madeAt'] as Timestamp).toDate().toIso8601String(),
    };
    await _localDataSource.cacheTeachers(jsonEncode(map));
    return map;
  }

  List<Teacher> _parseTeacherList(Map<String, dynamic> data) {
    return (data['teachers'] as List).map((e) => Teacher.fromJson(e)).toList();
  }
}

@riverpod
TeacherRepository teacherRepository(Ref ref) {
  final local = ref.watch(teacherLocalDataSourceProvider);
  final remote = ref.watch(teacherRemoteDataSourceProvider);
  return TeacherRepositoryImpl(local, remote);
}
