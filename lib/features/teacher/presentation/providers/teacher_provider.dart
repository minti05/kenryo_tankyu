import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:kenryo_tankyu/core/constants/work/search_value.dart';
import 'package:kenryo_tankyu/features/teacher/domain/models/teacher.dart';
import 'package:kenryo_tankyu/features/user_archive/presentation/providers/providers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kenryo_tankyu/core/providers/firebase_providers.dart';
import 'package:kenryo_tankyu/core/providers/shared_preferences_provider.dart';

// 教師データを取得するProvider
final getFirestoreTeacherProvider =
    FutureProvider.autoDispose<List<Teacher>>((ref) async {
  try {
    final sharedPreferences = ref.read(sharedPreferencesProvider);
    final firestore = ref.read(firebaseFirestoreProvider);
    final cachedData = sharedPreferences.getString('teacherData');
    final DateTime currentDate = DateTime.now();

    debugPrint("現在時刻: $currentDate");
    if (cachedData != null) {
      debugPrint("キャッシュデータあり: ${cachedData.length}");
      final Map<String, dynamic> cachedMap = jsonDecode(cachedData);
      final DateTime lastViewed = DateTime.parse(cachedMap['lastViewed']);
      debugPrint("キャッシュの最終閲覧日時: $lastViewed");

      // 月が変わっている場合はサーバーから取得
      if (currentDate.month != lastViewed.month ||
          currentDate.year != lastViewed.year) {
        debugPrint("月が変わっているためサーバーからデータを取得します");
        final data = await fetchAndCacheTeachers(sharedPreferences, firestore);
        debugPrint("サーバーから取得したデータ: ${data.length}");
        return parseTeacherList(data);
      }

      // キャッシュデータを更新して返す
      debugPrint("キャッシュデータを更新して返します");
      cachedMap['lastViewed'] = currentDate.toIso8601String();
      await sharedPreferences.setString('teacherData', jsonEncode(cachedMap));
      return parseTeacherList(cachedMap);
    } else {
      // キャッシュがない場合はサーバーから取得
      debugPrint("キャッシュデータがないためサーバーからデータを取得します");
      final data = await fetchAndCacheTeachers(sharedPreferences, firestore);
      debugPrint("サーバーから取得したデータ: ${data.length}");
      return parseTeacherList(data);
    }
  } catch (e) {
    debugPrint("教師データ取得エラー: $e");
    return [];
  }
});

Future<Map<String, dynamic>> fetchAndCacheTeachers(
    SharedPreferences sharedPreferences, FirebaseFirestore firestore) async {
  final data = await getTeachersFromFirestore(firestore);

  final map = {
    'teachers': data['teachers'],
    'lastViewed': DateTime.now().toIso8601String(),
    'madeAt': (data['madeAt'] as Timestamp).toDate().toIso8601String(),
  };
  await sharedPreferences.setString('teacherData', jsonEncode(map));
  return map;
}

List<Teacher> parseTeacherList(Map<String, dynamic> data) {
  return (data['teachers'] as List).map((e) => Teacher.fromJson(e)).toList();
}

Future<Map<String, dynamic>> getTeachersFromFirestore(
    FirebaseFirestore firestore) async {
  final snapshot = await firestore
      .collection('teachers')
      .orderBy('madeAt', descending: true)
      .limit(1)
      .get();
  return snapshot.docs.first.data();
}

final selectedTeacherProvider =
    StateProvider<Teacher>((ref) => Teacher.empty());

final getPdfProvider = FutureProvider.autoDispose<Uint8List?>((ref) async {
  final selectedTeacher = ref.watch(selectedTeacherProvider);
  final repository = ref.watch(userArchiveRepositoryProvider);
  final localData = await repository.getLocalPdf(selectedTeacher.id);
  if (localData != null) {
    return localData;
  }
  final remoteData =
      await repository.getRemotePdfForTeacher(selectedTeacher.id);
  return remoteData;
});

final teacherSortedListProvider =
    StateNotifierProvider.autoDispose<TeacherSortedListNotifier, List<Teacher>>(
        (ref) {
  final data = ref.watch(getFirestoreTeacherProvider).asData?.value ?? [];
  return TeacherSortedListNotifier(data);
});

class TeacherSortedListNotifier extends StateNotifier<List<Teacher>> {
  TeacherSortedListNotifier(super.state);

  void sortList(SortTypeForTeacher sortType) {
    switch (sortType) {
      case SortTypeForTeacher.nameAscendingOrder:
        state = [...state]..sort((a, b) => a.nameKana.compareTo(b.nameKana));
        break;
      case SortTypeForTeacher.nameDescendingOrder:
        state = [...state]..sort((a, b) => b.nameKana.compareTo(a.nameKana));
        break;
      case SortTypeForTeacher.subjectOrder:
        state = [...state]
          ..sort((a, b) => a.subject.index.compareTo(b.subject.index));
        break;
      case SortTypeForTeacher.gradeOrder:
        state = [...state]..sort(
            (a, b) => a.gradeInCharge.index.compareTo(b.gradeInCharge.index));
        break;
    }
    state = state;
  }
}

final sortedTypeForTeacherProvider = StateProvider<SortTypeForTeacher>(
    (ref) => SortTypeForTeacher.nameAscendingOrder);
