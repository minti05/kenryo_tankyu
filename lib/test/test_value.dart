import 'package:kenryo_tankyu/features/notification/domain/models/notification_content.dart';

final NotificationContent testNotificationValue = NotificationContent(
  id: 'test',
  headerImagePath: 'test',
  title: 'β版リリース！',
  contents:
      '遂にβ版がリリースされました！\n2021年度入学生の探究作品の「キーワード検索」「カテゴリ検索」「お気に入り登録」などが使えるほか、縣陵先生図鑑も公開しています！\n\nバグや要望は以下のリンクからお知らせください！\nhttps://forms.gle/xUXX88MJ5fLsVtAk9',
  sendAt: DateTime(2025, 1, 3, 10, 0),
  savedAt: DateTime(2025, 1, 3, 10, 0),
  isRead: false,
  type: NotificationType.update,
);
