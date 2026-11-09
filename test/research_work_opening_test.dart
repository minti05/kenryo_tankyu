import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kenryo_tankyu/core/error/failures.dart';
import 'package:kenryo_tankyu/features/research_work/data/repositories/research_work_repository_impl.dart';
import 'package:kenryo_tankyu/features/research_work/domain/models/searched.dart';
import 'package:kenryo_tankyu/features/research_work/domain/repositories/research_work_repository.dart';
import 'package:kenryo_tankyu/features/research_work/presentation/providers/searched_provider.dart';
import 'package:kenryo_tankyu/features/user_archive/domain/repositories/user_archive_repository.dart';
import 'package:kenryo_tankyu/features/user_archive/presentation/providers/user_archive_providers.dart';

final work = Searched.fromJson({
  'documentID': 22202363,
  'title': 'テスト作品',
  'enterYear': 2022,
  'category1': 'none',
  'subCategory1': 'none',
  'category2': 'none',
  'subCategory2': 'none',
  'eventName': 'individualTankyu',
  'course': 'general',
  'existsPoster': true,
  'isCached': false,
});

class WorkRepository implements ResearchWorkRepository {
  @override
  Future<Searched> getWork(String documentID) async => work;
}

class UnavailableArchive implements UserArchiveRepository {
  final write = Completer<void>();
  Searched? recorded;

  @override
  Future<Searched?> getHistory(int documentID) async =>
      throw const ServerFailure(code: '401');

  @override
  Future<void> insertHistory(Searched searched) {
    recorded = searched;
    return write.future;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  test('履歴の認証エラーや保存待ちがあっても作品詳細を取得できる', () async {
    final archive = UnavailableArchive();
    final container = ProviderContainer.test(
      retry: (_, __) => null,
      overrides: [
        researchWorkRepositoryProvider.overrideWithValue(WorkRepository()),
        userArchiveRepositoryProvider.overrideWithValue(archive),
      ],
    );
    final provider = researchWorkProvider(work.documentID);
    container.listen(provider, (_, __) {});

    expect(await container.read(provider.future), work);
    expect(archive.recorded, work);
    expect(archive.write.isCompleted, isFalse);

    archive.write.completeError(const ServerFailure(code: '401'));
    await container.pump();
    expect(container.read(provider).requireValue, work);
  });
}
