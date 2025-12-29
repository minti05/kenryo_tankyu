import 'package:kenryo_tankyu/features/research_work/domain/models/searched.dart';

abstract class ResearchWorkRepository {
  Future<Searched> getWork(String documentID);
}
