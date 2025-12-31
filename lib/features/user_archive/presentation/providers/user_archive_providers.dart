import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:kenryo_tankyu/core/constants/work/info_value.dart';
import 'package:kenryo_tankyu/core/error/failures.dart';
import 'package:kenryo_tankyu/features/research_work/domain/models/searched.dart';
import 'package:kenryo_tankyu/features/research_work/presentation/providers/searched_provider.dart';
import 'package:kenryo_tankyu/features/user_archive/data/datasources/pdf_local_data_source.dart';
import 'package:kenryo_tankyu/features/user_archive/data/datasources/recommended_works_local_data_source.dart';
import 'package:kenryo_tankyu/features/user_archive/data/datasources/searched_history_local_data_source.dart';
import 'package:kenryo_tankyu/features/user_archive/data/datasources/user_archive_remote_data_source.dart';
import 'package:kenryo_tankyu/features/user_archive/data/repositories/user_archive_repository_impl.dart';
import 'package:kenryo_tankyu/features/user_archive/domain/repositories/user_archive_repository.dart';
import 'package:kenryo_tankyu/presentation/widget/error_dialog.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_archive_providers.g.dart';

@riverpod
UserArchiveRepository userArchiveRepository(Ref ref) {
  final historyDataSource = ref.watch(searchedHistoryLocalDataSourceProvider);
  final pdfDataSource = ref.watch(pdfLocalDataSourceProvider);
  final recommendedDataSource =
      ref.watch(recommendedWorksLocalDataSourceProvider);
  final remoteDataSource = ref.watch(userArchiveRemoteDataSourceProvider);

  return UserArchiveRepositoryImpl(
    historyDataSource,
    pdfDataSource,
    recommendedDataSource,
    remoteDataSource,
  );
}

/// ボタン連打防止を管理するProvider
@riverpod
class AbleChangeFavorite extends _$AbleChangeFavorite {
  @override
  bool build() => true;

  void set(bool value) => state = value;
}

@riverpod
class UserIsFavoriteState extends _$UserIsFavoriteState {
  @override
  Future<bool> build(int documentID) async {
    final repository = ref.watch(userArchiveRepositoryProvider);
    return repository.getFavoriteState(documentID);
  }

  /// お気に入り状態を反転させる
  /// [documentID] 対象のドキュメントID
  /// [context] エラーダイアログ表示用。Widget側でmountedチェックをしてから渡すこと。
  Future<void> toggle(int documentID, BuildContext context) async {
    // すでに処理中の場合は何もしない（連打防止）
    if (state.isLoading) return;

    final repository = ref.read(userArchiveRepositoryProvider);
    final previousState = state;
    final bool currentIsFavorite = state.asData?.value ?? false;
    final bool nextIsFavorite = !currentIsFavorite;

    // ローディング状態に移行
    state = const AsyncLoading<bool>();

    state = await AsyncValue.guard(() async {
      // Repository handles both local DB and remote Firestore updates
      await repository.changeFavoriteState(documentID, nextIsFavorite);

      // 関連するProviderを無効化
      ref.invalidate(searchedHistoryProvider);
      ref.invalidate(researchWorkProvider(documentID));

      return nextIsFavorite;
    });

    // エラーハンドリング
    if (state.hasError && context.mounted) {
      final error = state.error;
      if (error is Failure) {
        showErrorDialog(context, error);
      } else {
        showErrorDialog(context, UnknownFailure(message: error.toString()));
      }
      // エラー時は前の状態に戻す（楽観的UIに近い挙動にする場合などは検討が必要だが、
      // ここではRepositoryの失敗＝状態不整合なので、確実に取得し直すか前の値に戻す）
      state = previousState;
    }
  }
}

@riverpod
Future<List<Searched>?> searchedHistory(Ref ref, bool onlyShowFavorite) async {
  final repository = ref.watch(userArchiveRepositoryProvider);
  if (onlyShowFavorite) {
    return repository.getFavoriteHistory();
  } else {
    return repository.getAllHistory();
  }
}

@riverpod
class HistoryController extends _$HistoryController {
  @override
  void build() {}

  Future<void> deleteHistory(int id) async {
    final repository = ref.read(userArchiveRepositoryProvider);
    await repository.deleteHistory(id);
    ref.invalidate(searchedHistoryProvider);
  }
}

@riverpod
Future<Uint8List?> pdf(Ref ref, String id, EnterYear enterYear) async {
  final repository = ref.watch(userArchiveRepositoryProvider);
  return repository.getPdf(id, enterYear);
}

@riverpod
Future<Uint8List?> teacherPdf(Ref ref, String id) async {
  final repository = ref.watch(userArchiveRepositoryProvider);
  return repository.getTeacherPdf(id);
}
