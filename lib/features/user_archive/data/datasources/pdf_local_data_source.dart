import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

import "package:kenryo_tankyu/core/constants/work/info_value.dart";
import 'package:kenryo_tankyu/core/providers/firebase_providers.dart';
import 'package:kenryo_tankyu/features/user_archive/domain/models/archive_stats.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pdf_local_data_source.g.dart';

@Riverpod(keepAlive: true)
PdfLocalDataSource pdfLocalDataSource(Ref ref) {
  final storage = ref.watch(firebaseStorageProvider);
  return PdfLocalDataSource(storage);
}

class PdfLocalDataSource {
  final FirebaseStorage _storage;

  PdfLocalDataSource(this._storage);

  Future<Database> get database async {
    try {
      return openDatabase(
        join(await getDatabasesPath(), 'works_pdf.db'),
        onCreate: (db, version) {
          return db.execute(
            'CREATE TABLE works_pdf('
            'id TEXT PRIMARY KEY NOT NULL, '
            'pdfData BLOB NOT NULL, '
            'savedAt TEXT NOT NULL, '
            'CHECK(LENGTH(id) == 8 OR LENGTH(id) == 5),'
            'CHECK(pdfData != null) '
            ');',
          );
        },
        version: 3,
      );
    } catch (error, stackTrace) {
      return Future.error(error, stackTrace);
    }
  }

  Future<void> insertPdf(String id, Uint8List pdfData) async {
    final Database db = await database;
    await db.insert(
      'works_pdf',
      {
        'id': id,
        'pdfData': pdfData,
        'savedAt': DateTime.now().toIso8601String(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Uint8List?> getLocalPdf(String id) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('works_pdf',
        columns: ['pdfData'], where: 'id = ?', whereArgs: [id]);
    if (maps.isEmpty) {
      return null;
    }
    return maps[0]['pdfData'];
  }

  Future<Uint8List?> getRemotePdf(String id, EnterYear enterYear) async {
    //idからpdfの種類を取得する
    final DocumentType documentType =
        DocumentType.values.firstWhere((e) => e.idSuffix == id.substring(7));

    final pathReference = _storage.ref().child(
        'works_2025_latest/${enterYear.name}/${documentType.name}/$id.pdf');
    const storage = 1024 * 1024 * 3;

    ///これ以上のサイズ（3MB）のファイルは読み込めないように設定してあります。
    final Uint8List? remoteData = await pathReference.getData(storage);
    remoteData != null ? await insertPdf(id, remoteData) : null;

    return remoteData;
  }

  Future<Uint8List?> getRemotePdfForTeacher(String id) async {
    final pathReference = _storage.ref().child('teachers/$id.pdf');
    const storage = 1024 * 1024 * 3;

    ///これ以上のサイズ（3MB）のファイルは読み込めないように設定してあります。
    final Uint8List? remoteData = await pathReference.getData(storage);
    remoteData != null ? await insertPdf(id, remoteData) : null;

    return remoteData;
  }

  Future<void> deleteAllPdf() async {
    final Database db = await database;
    await db.delete('works_pdf');
  }

  Future<void> deletePdfBefore(DateTime date) async {
    final Database db = await database;
    await db.delete(
      'works_pdf',
      where: 'savedAt < ?',
      whereArgs: [date.toIso8601String()],
    );
  }

  Future<List<PdfCacheEntry>> getAllCacheEntries() async {
    final Database db = await database;
    final result = await db.rawQuery(
      'SELECT savedAt, LENGTH(pdfData) as bytes FROM works_pdf',
    );
    return result
        .map((r) => (
              date: DateTime.parse(r['savedAt'] as String),
              bytes: (r['bytes'] as int?) ?? 0,
            ))
        .toList();
  }

  Future<PdfCacheStats> getPdfCacheStats() async {
    final Database db = await database;
    final result = await db.rawQuery(
      'SELECT COUNT(*) as count, SUM(LENGTH(pdfData)) as totalBytes, MIN(savedAt) as oldest, MAX(savedAt) as newest FROM works_pdf',
    );
    if (result.isEmpty) {
      return (count: 0, totalBytes: 0, oldest: null, newest: null);
    }
    final row = result[0];
    final count = (row['count'] as int?) ?? 0;
    final totalBytes = (row['totalBytes'] as int?) ?? 0;
    final oldestStr = row['oldest'] as String?;
    final newestStr = row['newest'] as String?;
    return (
      count: count,
      totalBytes: totalBytes,
      oldest: oldestStr != null ? DateTime.parse(oldestStr) : null,
      newest: newestStr != null ? DateTime.parse(newestStr) : null,
    );
  }
}
