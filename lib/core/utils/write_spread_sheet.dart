import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:flutter/services.dart';
import 'package:kenryo_tankyu/features/auth/presentation/providers/auth_repository_provider.dart';

class EditSpreadSheet {
  static final EditSpreadSheet _instance = EditSpreadSheet._internal();
  EditSpreadSheet._internal();
  static EditSpreadSheet get instance => _instance;

  static const _spreadsheetId = '1g9kG-6wlBxWQ-kq4tyFtWjRJvJbWqLNLoJ_C67WYmaw';

  // シートごとの範囲（1行目がヘッダー行）
  static const _rangeSuggestCategory = 'suggest_other_category!A1';
  static const _rangeSuggestWorksInfo = 'suggest_works_info!A1';
  static const _rangeCannotViewPdf = 'cannot_view_pdf!A1';
  static const _rangeOtherReason = 'other_reason!A1';

  String _jstTimestamp() {
    final now = DateTime.now().toUtc().add(const Duration(hours: 9));
    final y = now.year;
    final mo = now.month.toString().padLeft(2, '0');
    final d = now.day.toString().padLeft(2, '0');
    final h = now.hour.toString().padLeft(2, '0');
    final mi = now.minute.toString().padLeft(2, '0');
    final s = now.second.toString().padLeft(2, '0');
    return '$y-$mo-$d $h:$mi:$s';
  }

  String _getUserEmail(WidgetRef ref) {
    return ref.read(authRepositoryProvider).currentUser?.email ?? 'guest';
  }

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
    final values = [
      _jstTimestamp(),
      _getUserEmail(ref),
      documentID.toString(),
      radioLabel,
      newCategory,
      newSubCategory,
    ];
    await _append(_rangeSuggestCategory, values);
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
    final values = [
      _jstTimestamp(),
      _getUserEmail(ref),
      documentID.toString(),
      author,
      title,
      course,
      enterYear,
    ];
    await _append(_rangeSuggestWorksInfo, values);
  }

  /// PDF閲覧不可報告を送信
  Future<void> submitCannotViewPdf(
    WidgetRef ref,
    int documentID,
    List<String> pdfTypes,
    String freeDescription,
  ) async {
    final values = [
      _jstTimestamp(),
      _getUserEmail(ref),
      documentID.toString(),
      pdfTypes.join(', '),
      freeDescription,
    ];
    await _append(_rangeCannotViewPdf, values);
  }

  /// その他の理由を送信
  Future<void> submitOtherReason(
    WidgetRef ref,
    int documentID,
    String freeText,
  ) async {
    final values = [
      _jstTimestamp(),
      _getUserEmail(ref),
      documentID.toString(),
      freeText,
    ];
    await _append(_rangeOtherReason, values);
  }

  Future<void> _append(String range, List<String> values) async {
    final credentials =
        await rootBundle.loadString('assets/sheets_service_account.json');
    final jsonCredentials = jsonDecode(credentials);

    final client = await clientViaServiceAccount(
      ServiceAccountCredentials.fromJson(jsonCredentials),
      [SheetsApi.spreadsheetsScope],
    );

    try {
      final sheetsApi = SheetsApi(client);
      final request = ValueRange(values: [values]);

      await sheetsApi.spreadsheets.values
          .append(request, _spreadsheetId, range, valueInputOption: 'RAW');
    } finally {
      client.close();
    }
  }
}
