import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kenryo_tankyu/core/error/failures.dart';
import 'package:kenryo_tankyu/features/notification/data/datasources/notification_local_data_source.dart';
import 'package:kenryo_tankyu/features/notification/data/datasources/notification_remote_data_source.dart';
import 'package:kenryo_tankyu/features/notification/domain/models/notification_content.dart';
import 'package:kenryo_tankyu/features/notification/domain/repositories/notification_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_repository_impl.g.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  NotificationRepositoryImpl(this._localDataSource, this._remoteDataSource);

  final NotificationLocalDataSource _localDataSource;
  final NotificationRemoteDataSource _remoteDataSource;

  @override
  Future<List<NotificationContent>> fetchNotifications() async {
    try {
      final localData = await _localDataSource.read(0);
      if (localData != null && localData.isNotEmpty) {
        return localData;
      } else {
        return await _remoteDataSource.fetchLatestNotifications();
      }
    } catch (e) {
      throw _mapException(e);
    }
  }

  @override
  Future<void> markAsRead(int id) async {
    try {
      await _localDataSource.markAsRead(id);
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
NotificationRepository notificationRepository(Ref ref) {
  final local = ref.watch(notificationLocalDataSourceProvider);
  final remote = ref.watch(notificationRemoteDataSourceProvider);
  return NotificationRepositoryImpl(local, remote);
}
