import 'package:kenryo_tankyu/core/error/error_mapper.dart';
import 'package:kenryo_tankyu/features/research_work/data/datasources/research_work_data_source.dart';
import 'package:kenryo_tankyu/features/research_work/domain/models/searched.dart';
import 'package:kenryo_tankyu/features/research_work/domain/repositories/research_work_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'research_work_repository_impl.g.dart';

class ResearchWorkRepositoryImpl
    with ErrorMapper
    implements ResearchWorkRepository {
  ResearchWorkRepositoryImpl(this._dataSource);

  final ResearchWorkDataSource _dataSource;

  @override
  Future<Searched> getWork(String documentID) async {
    try {
      return await _dataSource.fetchWork(documentID);
    } catch (e) {
      throw mapException(e);
    }
  }
}

@riverpod
ResearchWorkRepository researchWorkRepository(Ref ref) {
  final dataSource = ref.watch(researchWorkDataSourceProvider);
  return ResearchWorkRepositoryImpl(dataSource);
}
