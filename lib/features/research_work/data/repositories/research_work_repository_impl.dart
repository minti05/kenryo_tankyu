import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kenryo_tankyu/core/error/failures.dart';
import 'package:kenryo_tankyu/features/research_work/data/datasources/research_work_data_source.dart';
import 'package:kenryo_tankyu/features/research_work/domain/models/searched.dart';
import 'package:kenryo_tankyu/features/research_work/domain/repositories/research_work_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'research_work_repository_impl.g.dart';

class ResearchWorkRepositoryImpl implements ResearchWorkRepository {
  ResearchWorkRepositoryImpl(this._dataSource);

  final ResearchWorkDataSource _dataSource;

  @override
  Future<Searched> getWork(String documentID) async {
    try {
      return await _dataSource.fetchWork(documentID);
    } catch (e) {
      throw _mapException(e);
    }
  }

  Failure _mapException(dynamic e) {
    if (e is SocketException) {
      return const NetworkFailure();
    }
    if (e is FirebaseException) {
      if (e.code == 'unavailable' || e.code == 'network-request-failed') {
        return const NetworkFailure();
      }
      return ServerFailure(
          message: e.message ?? 'サーバーエラーが発生しました。', code: e.code);
    }
    if (e is Failure) {
      return e;
    }
    return UnknownFailure(message: e.toString());
  }
}

@riverpod
ResearchWorkRepository researchWorkRepository(Ref ref) {
  final dataSource = ref.watch(researchWorkDataSourceProvider);
  return ResearchWorkRepositoryImpl(dataSource);
}
