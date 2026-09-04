import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kenryo_tankyu/features/auth/presentation/providers/auth_repository_provider.dart';

class EditSpreadSheet {
  static final EditSpreadSheet _instance = EditSpreadSheet._internal();
  EditSpreadSheet._internal();
  static EditSpreadSheet get instance => _instance;

  static const _functionRegion = 'asia-northeast1';
  static const _functionName = 'submitSheetReport';

  /// カテゴリ変更提案を送信
  /// [radioLabel]: 修正対象（"カテゴリ1" or "カテゴリ2"）
  /// [newCategory]: 新しいカテゴリ名
  /// [newSubCategory]: 新しいサブカテゴリ名
  Future<void> submitSuggestCategory(
    WidgetRef ref,
    int documentID,
    String radioLabel,
    String newCategory,
    String newSubCategory,
  ) async {
    await _submit(ref, {
      'type': 'suggestCategory',
      'documentId': documentID,
      'radioLabel': radioLabel,
      'newCategory': newCategory,
      'newSubCategory': newSubCategory,
    });
  }

  /// 作品情報変更提案を送信
  Future<void> submitSuggestWorksInfo(
    WidgetRef ref,
    int documentID,
    String author,
    String title,
    String course,
    String enterYear,
  ) async {
    await _submit(ref, {
      'type': 'suggestWorksInfo',
      'documentId': documentID,
      'author': author,
      'title': title,
      'course': course,
      'enterYear': enterYear,
    });
  }

  /// PDF閲覧不可報告を送信
  Future<void> submitCannotViewPdf(
    WidgetRef ref,
    int documentID,
    List<String> pdfTypes,
    String freeDescription,
  ) async {
    await _submit(ref, {
      'type': 'cannotViewPdf',
      'documentId': documentID,
      'pdfTypes': pdfTypes,
      'freeDescription': freeDescription,
    });
  }

  /// その他の理由を送信
  Future<void> submitOtherReason(
    WidgetRef ref,
    int documentID,
    String freeText,
  ) async {
    await _submit(ref, {
      'type': 'otherReason',
      'documentId': documentID,
      'freeText': freeText,
    });
  }

  Future<void> _submit(WidgetRef ref, Map<String, Object?> report) async {
    final user = ref.read(authRepositoryProvider).currentUser;
    if (user == null) {
      throw StateError('ログインが必要です。');
    }

    final idToken = await user.getIdToken();
    if (idToken == null || idToken.isEmpty) {
      throw StateError('認証情報を取得できませんでした。');
    }

    final projectId = Firebase.app().options.projectId;
    final uri = Uri.https(
      '$_functionRegion-$projectId.cloudfunctions.net',
      _functionName,
    );
    final client = HttpClient();
    try {
      final request = await client.postUrl(uri);
      request.headers.contentType = ContentType.json;
      request.headers.set(HttpHeaders.authorizationHeader, 'Bearer $idToken');
      request.write(jsonEncode({'data': report}));

      final response = await request.close();
      final body = await response.transform(utf8.decoder).join();
      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw StateError('送信に失敗しました。(${response.statusCode}) $body');
      }
    } finally {
      client.close(force: true);
    }
  }
}
