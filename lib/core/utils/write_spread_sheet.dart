import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:flutter/services.dart';
import 'package:kenryo_tankyu/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:kenryo_tankyu/features/research_work/domain/models/searched.dart';

class EditSpreadSheet {
  static final EditSpreadSheet _instance = EditSpreadSheet._internal();
  EditSpreadSheet._internal();
  static EditSpreadSheet get instance => _instance;

  static const sheetListRange = [
    'suggest_other_category!A1:G1',
    'suggest_works_info!A1:F1',
    'cannot_view_pdf!A1:F1',
    'other_reason!A1:C1'
  ];

  Future<void> editSpreadSheet(BuildContext context, WidgetRef ref,
      Searched searched, String? selected) async {
    int number = 0;
    String? userEmail =  ref.read(authRepositoryProvider).currentUser?.email;
    List<String> values = [];
    await addDataToSheet(
        sheetListRange[number], values, userEmail?? 'guest', searched.documentID);
  }

  Future<void> addDataToSheet(String range, List<String> values,
      String userEmail, int documentID) async {
    // 認証情報ファイルの読み込み
    final credentials = await rootBundle
        .loadString('assets/your_service_account_credentials.json');
    final jsonCredentials = jsonDecode(credentials);

    // OAuth2クライアントを作成
    final client = await clientViaServiceAccount(
      ServiceAccountCredentials.fromJson(jsonCredentials),
      [SheetsApi.spreadsheetsScope],
    );

    final sheetsApi = SheetsApi(client);

    // スプレッドシートのIDと範囲を指定
    const spreadsheetId = '1g9kG-6wlBxWQ-kq4tyFtWjRJvJbWqLNLoJ_C67WYmaw';

    values = [userEmail, documentID.toString(), ...values];
    var request = ValueRange(values: [values]);

    // スプレッドシートにデータを追加
    await sheetsApi.spreadsheets.values
        .append(request, spreadsheetId, range, valueInputOption: 'RAW');
  }
}
