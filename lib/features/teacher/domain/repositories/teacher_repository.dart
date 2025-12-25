import 'package:kenryo_tankyu/features/teacher/domain/models/teacher.dart';

abstract class TeacherRepository {
  Future<List<Teacher>> getTeachers();
}
