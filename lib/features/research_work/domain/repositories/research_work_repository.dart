import 'package:kenryo_tankyu/features/research_work/domain/models/models.dart';

abstract class ResearchWorkRepository {
  Future<Searched> getWork(String documentID);
}
