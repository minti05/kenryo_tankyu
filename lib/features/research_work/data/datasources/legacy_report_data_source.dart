import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

/// 旧フォームの内容を既存の報告APIへ送る。管理用の認証情報は使用しない。
class LegacyReportDataSource {
  Future<void> submit({
    required String token,
    required String documentID,
    required String description,
    http.Client? client,
  }) async {
    if (!RegExp(r'^\d{8}$').hasMatch(documentID) ||
        description.length > 2000 ||
        description.trim().isEmpty ||
        token.isEmpty) {
      throw ArgumentError('報告内容を確認してください。');
    }
    final body = jsonEncode({
      'operationId': const Uuid().v4(),
      'issuedAt': DateTime.now().toUtc().toIso8601String(),
      'documentID': documentID,
      'kind': 'other',
      'details': {'description': description},
    });
    if (utf8.encode(body).length > 8192) {
      throw ArgumentError('報告内容が長すぎます。');
    }
    final transport = client ?? http.Client();
    try {
      final request = http.Request(
        'POST',
        Uri.parse('https://kenryo-tankyu-archive.pages.dev/api/reports'),
      )
        ..followRedirects = false
        ..headers.addAll({
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        })
        ..body = body;
      final response = await http.Response.fromStream(
        await transport.send(request).timeout(const Duration(seconds: 20)),
      ).timeout(const Duration(seconds: 20));
      if (response.statusCode != 200 ||
          jsonDecode(response.body)['status'] != 'received') {
        throw StateError('報告を受け付けられませんでした。');
      }
    } finally {
      if (client == null) transport.close();
    }
  }
}
