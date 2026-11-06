import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:kenryo_tankyu/features/research_work/data/datasources/legacy_report_data_source.dart';

void main() {
  test('報告を学校アカウントのトークンで送信し、受付を確認する', () async {
    final client = MockClient((request) async {
      expect(request.url.toString(),
          'https://kenryo-tankyu-archive.pages.dev/api/reports');
      expect(request.headers['Authorization'], 'Bearer test-token');
      expect(request.followRedirects, isFalse);
      final body = jsonDecode(request.body) as Map<String, dynamic>;
      expect(body['documentID'], '20260001');
      expect(body['details']['description'], 'PDFが開けません');
      expect(
          body['operationId'],
          matches(
              r'^[a-f0-9]{8}-[a-f0-9]{4}-4[a-f0-9]{3}-[89ab][a-f0-9]{3}-[a-f0-9]{12}$'));
      return http.Response('{"status":"received"}', 200);
    });
    addTearDown(client.close);
    await LegacyReportDataSource().submit(
      token: 'test-token',
      documentID: '20260001',
      description: 'PDFが開けません',
      client: client,
    );
  });

  test('認証拒否や受付未完了を送信成功として扱わない', () async {
    for (final response in [
      http.Response('{"error":"unauthorized"}', 401),
      http.Response('{}', 200),
    ]) {
      final client = MockClient((_) async => response);
      addTearDown(client.close);
      await expectLater(
          LegacyReportDataSource().submit(
            token: 'test-token',
            documentID: '20260001',
            description: '報告',
            client: client,
          ),
          throwsStateError);
    }
  });
}
