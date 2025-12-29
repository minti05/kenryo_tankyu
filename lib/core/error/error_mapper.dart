import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kenryo_tankyu/core/error/failures.dart';
import 'package:sqflite/sqflite.dart';

/// リポジトリ層で例外を Failure に変換するための Mixin
mixin ErrorMapper {
  Failure mapException(dynamic e) {
    if (e is SocketException) {
      return const NetworkFailure();
    }

    if (e is DatabaseException) {
      return DatabaseFailure(message: e.toString());
    }

    if (e is FirebaseException) {
      if (e.code == 'unavailable' || e.code == 'network-request-failed') {
        return const NetworkFailure();
      }
      return ServerFailure(
        message: e.message ?? 'サーバーエラーが発生しました。',
        code: e.code,
      );
    }

    if (e is Failure) {
      return e;
    }

    return UnknownFailure(message: e.toString());
  }
}
