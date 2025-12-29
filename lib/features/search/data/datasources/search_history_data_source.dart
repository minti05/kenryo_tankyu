import 'package:flutter/material.dart';
import 'package:kenryo_tankyu/features/search/domain/models/search.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

part 'search_history_data_source.g.dart';

class SearchHistoryDataSource {
  static final SearchHistoryDataSource _instance = SearchHistoryDataSource._();
  SearchHistoryDataSource._();
  static SearchHistoryDataSource get instance => _instance;

  Future<Database> get database async {
    try {
      return openDatabase(
        join(await getDatabasesPath(), 'search_history.db'),
        onCreate: (db, version) {
          return db.execute('CREATE TABLE search_history('
              'id INTEGER PRIMARY KEY AUTOINCREMENT,'
              'category TEXT NOT NULL DEFAULT "", '
              'subCategory TEXT NOT NULL DEFAULT "", '
              'enterYear INTEGER NOT NULL DEFAULT 0, '
              'eventName TEXT NOT NULL DEFAULT "", '
              'course TEXT NOT NULL DEFAULT "", '
              'searchWord TEXT NOT NULL DEFAULT "", '
              'savedAt TEXT NOT NULL, '
              'numberOfHits INTEGER NOT NULL DEFAULT 0, '
              'CHECK(category != "" OR subCategory != "" OR enterYear != 0 OR eventName != "" OR course != "" OR searchWord != "") '
              'UNIQUE(category, subCategory, enterYear, eventName, course, searchWord) '
              ');');
        },
        version: 21,
      );
    } catch (error, stackTrace) {
      return Future.error(error, stackTrace);
    }
  }

  Future<void> deleteAllHistory() async {
    final Database db = await database;
    await db.delete('search_history');
  }

  Future<void> insertHistory(Search search) async {
    final Database db = await database;
    await db.insert(
      'search_history',
      search.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Search>?> getAllHistory() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('search_history', orderBy: 'savedAt DESC');
    if (maps.isEmpty) {
      return null;
    }
    return List.generate(maps.length, (i) {
      debugPrint(maps[i].toString());
      return Search.fromJson(maps[i]);
    });
  }
}

@riverpod
SearchHistoryDataSource searchHistoryDataSource(Ref ref) {
  return SearchHistoryDataSource.instance;
}
