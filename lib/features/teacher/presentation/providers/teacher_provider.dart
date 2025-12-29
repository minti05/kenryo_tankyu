
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:kenryo_tankyu/core/constants/work/search_value.dart';
import 'package:kenryo_tankyu/features/teacher/domain/models/teacher.dart';
import 'package:kenryo_tankyu/features/user_archive/presentation/providers/user_archive_providers.dart';
import 'package:kenryo_tankyu/features/teacher/data/repositories/teacher_repository_impl.dart';

// 教師データを取得するProvider
final getFirestoreTeacherProvider =
    FutureProvider.autoDispose<List<Teacher>>((ref) async {
  final repository = ref.watch(teacherRepositoryProvider);
  return repository.getTeachers();
});

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
