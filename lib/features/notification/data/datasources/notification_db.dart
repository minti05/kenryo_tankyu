import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kenryo_tankyu/features/notification/domain/models/notification_content.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NotificationDbController {
  //特定の日付以降のデータを取得する（多分使わない？？）
  static Future<List<NotificationContent>> readFromFirestore(DateTime fromWhen, FirebaseFirestore firestore) async {
    final QuerySnapshot snapshot = await firestore
        .collection('notification')
        .where('sendAt', isGreaterThanOrEqualTo: fromWhen).limit(4)
        .get();
    return snapshot.docs.map((doc) => NotificationContent.fromFirestore(doc)).toList();
  } 

  //最新順に取得する
  static Future<List<NotificationContent>> readFromFirestoreLatest(FirebaseFirestore firestore) async {
    final QuerySnapshot snapshot = await firestore
        .collection('notification')
        .orderBy('sendAt', descending: true).limit(4)
        .get();
    return snapshot.docs.map((doc) => NotificationContent.fromFirestore(doc)).toList();
  }

  static Future<Database> get database async {
    try {
      return openDatabase(
        join(await getDatabasesPath(), 'notification.db'),
        onCreate: (db, version) {
          return db.execute(
            'CREATE TABLE notification('
            'id INTEGER PRIMARY KEY AUTOINCREMENT,'
            'type TEXT NOT NULL, '
            'title TEXT NOT NULL, '
            'contents TEXT NOT NULL, '
            'sendAt TEXT NOT NULL, '
            'savedAt TEXT NOT NULL, '
            'isRead INTEGER NOT NULL, '
            'headerImage BLOB, '
            'CHECK(title != "" OR contents != "") '
            ');',
          );
        },
        version: 2,
      );
    } catch (error, stackTrace) {
      return Future.error(error, stackTrace);
    }
  }

  static Future<void> insert(NotificationContent notification) async {
    final Database db = await database;
    await db.insert(
      'notification',
      notification.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<NotificationContent>?> read(int paging) async {
    final Database db = await database;
    final int offset = (paging - 1) * 4;
    final List<Map<String, dynamic>> maps = await db.query(
      'notification',
      orderBy: 'sendAt DESC',
      limit: 4,
      offset: offset,
    );
    return List.generate(maps.length, (i) {
      return NotificationContent.fromSQLite(maps[i]);
    });
  }

  static Future<void> markAsRead(int id) async {
    final Database db = await database;
    await db.update(
      'notification',
      {'isRead': 1},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<void> markAsReadAll() async {
    final Database db = await database;
    await db.update(
      'notification',
      {'isRead': 1},
    );
  }
}
