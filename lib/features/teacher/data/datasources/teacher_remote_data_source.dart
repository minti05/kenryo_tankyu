import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kenryo_tankyu/core/providers/firebase_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'teacher_remote_data_source.g.dart';

abstract class TeacherRemoteDataSource {
  Future<Map<String, dynamic>> fetchTeachers();
}

class TeacherRemoteDataSourceImpl implements TeacherRemoteDataSource {
  TeacherRemoteDataSourceImpl(this._firestore);
  final FirebaseFirestore _firestore;

  @override
  Future<Map<String, dynamic>> fetchTeachers() async {
    final snapshot = await _firestore
        .collection('teachers')
        .orderBy('madeAt', descending: true)
        .limit(1)
        .get();
    return snapshot.docs.first.data();
  }
}

@riverpod
TeacherRemoteDataSource teacherRemoteDataSource(Ref ref) {
  final firestore = ref.watch(firebaseFirestoreProvider);
  return TeacherRemoteDataSourceImpl(firestore);
}
