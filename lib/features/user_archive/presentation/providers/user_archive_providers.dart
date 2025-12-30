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

/// documentIDごとにfavoriteかどうかを記録するProvider
@riverpod
class UserIsFavoriteState extends _$UserIsFavoriteState {
  @override
  Future<bool> build(int documentID) async {
    final repository = ref.watch(userArchiveRepositoryProvider);
    return repository.getFavoriteState(documentID);
  }

  Future<void> changeIsFavorite(int documentID, bool nowFavoriteState) async {
    final bool newFavoriteState = !nowFavoriteState;
    final repository = ref.read(userArchiveRepositoryProvider);

    // Repository handles both local DB and remote Firestore updates
    await repository.changeFavoriteState(documentID, newFavoriteState);

    state = AsyncValue.data(newFavoriteState);
    // Invalidate history provider so list updates
    ref.invalidate(searchedHistoryProvider);
    // Invalidate full work details as well
    ref.invalidate(researchWorkProvider(documentID));
  }

  Future<bool> toggle(
      int documentID, bool nowFavoriteState, BuildContext context) async {
    final canChange = ref.read(ableChangeFavoriteProvider);
    if (!canChange) return false;

    ref.read(ableChangeFavoriteProvider.notifier).set(false);

    try {
      await changeIsFavorite(documentID, nowFavoriteState);
    } on Failure catch (e) {
      if (context.mounted) {
        showErrorDialog(context, e);
      }
      ref.read(ableChangeFavoriteProvider.notifier).set(true);
      return false;
    } catch (e) {
      if (context.mounted) {
        showErrorDialog(context, UnknownFailure(message: e.toString()));
      }
      ref.read(ableChangeFavoriteProvider.notifier).set(true);
      return false;
    }

    // Don't await the delay for the return, but do await it for the flag reset
    Future.delayed(const Duration(seconds: 2)).then((_) {
      ref.read(ableChangeFavoriteProvider.notifier).set(true);
    });

    return true;
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
