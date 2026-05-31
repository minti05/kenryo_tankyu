import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:kenryo_tankyu/features/notification/domain/models/notification_content.dart';

List<NotificationContent> testNotifications = [
  NotificationContent(
    id: '1',
    headerImagePath: 'path1',
    title: 'タイトル1',
    contents: '内容1',
    sendAt: DateTime.now().subtract(Duration(days: 1)),
    savedAt: DateTime.now().subtract(Duration(days: 1)),
    type: NotificationType.system,
  ),
  NotificationContent(
    id: '2',
    headerImagePath: 'path2',
    title: 'タイトル2',
    contents: '内容2',
    sendAt: DateTime.now().subtract(Duration(days: 2)),
    savedAt: DateTime.now().subtract(Duration(days: 2)),
    type: NotificationType.system,
  ),
  NotificationContent(
    id: '3',
    headerImagePath: 'path3',
    title: 'タイトル3',
    contents: '内容3',
    sendAt: DateTime.now().subtract(Duration(days: 3)),
    savedAt: DateTime.now().subtract(Duration(days: 3)),
    type: NotificationType.info,
  ),
  NotificationContent(
    id: '4',
    headerImagePath: 'path4',
    title: 'タイトル4',
    contents: '内容4',
    sendAt: DateTime.now().subtract(Duration(days: 4)),
    savedAt: DateTime.now().subtract(Duration(days: 4)),
    type: NotificationType.warning,
  ),
  NotificationContent(
    id: '5',
    headerImagePath: 'path5',
    title: 'タイトル5',
    contents: '内容5',
    sendAt: DateTime.now().subtract(Duration(days: 5)),
    savedAt: DateTime.now().subtract(Duration(days: 5)),
    type: NotificationType.system,
  ),
  NotificationContent(
    id: '6',
    headerImagePath: 'path6',
    title: 'タイトル6',
    contents: '内容6',
    sendAt: DateTime.now().subtract(Duration(days: 6)),
    savedAt: DateTime.now().subtract(Duration(days: 6)),
    type: NotificationType.info,
  ),
  NotificationContent(
    id: '7',
    headerImagePath: 'path7',
    title: 'タイトル7',
    contents: '内容7',
    sendAt: DateTime.now().subtract(Duration(days: 7)),
    savedAt: DateTime.now().subtract(Duration(days: 7)),
    type: NotificationType.warning,
  ),
  NotificationContent(
    id: '8',
    headerImagePath: 'path8',
    title: 'タイトル8',
    contents: '内容8',
    sendAt: DateTime.now().subtract(Duration(days: 8)),
    savedAt: DateTime.now().subtract(Duration(days: 8)),
    type: NotificationType.system,
  ),
];

class FirestoreUpload {
  static Future<void> uploadTestNotifications() async {
    final notifications = testNotifications;
    for (final notification in notifications) {
      //保存しないフィールドを削除
      final json = notification.toJson();
      json.remove('savedAt');
      json.remove('id');
      //sendAtをtimestampに変換
      json['sendAt'] = Timestamp.fromDate(notification.sendAt);

      await FirebaseFirestore.instance
          .collection('notifications')
          .doc(notification.id)
          .set(json);
    }
  }
}
