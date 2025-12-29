import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kenryo_tankyu/core/utils/date_time_converter.dart';

part 'notification_content.freezed.dart';
part 'notification_content.g.dart';

@freezed
abstract class NotificationContent with _$NotificationContent {
  const NotificationContent._();

  const factory NotificationContent({
    required String id, //firestoreで自動で割り振られるID
    @NotificationTypeEnumConverter() required NotificationType type,
    required String
        headerImagePath, //firestore databaseに保存されているpngファイル名（.pngを抜いて）
    required String title,
    required String contents,
    @DateTimeConverter() required DateTime sendAt,
    @DateTimeConverter() required DateTime savedAt,
    required bool isRead,
  }) = _NotificationContent;

  factory NotificationContent.fromJson(Map<String, dynamic> json) =>
      _$NotificationContentFromJson(json);

  factory NotificationContent.fromSQLite(Map<String, dynamic> json) {
    final mutableJson = Map<String, dynamic>.from(json);
    mutableJson['isRead'] = mutableJson['isRead'] == 1;
    final notification = NotificationContent.fromJson(mutableJson);
    return notification;
  }

  factory NotificationContent.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final mutableJson = Map<String, dynamic>.from(data);
    mutableJson['isRead'] = false;
    mutableJson['savedAt'] = DateTime.now();
    mutableJson['id'] = doc.id;
    final notification = NotificationContent.fromJson(mutableJson);
    return notification;
  }

  Map<String, dynamic> toSQLite() {
    final json = toJson();
    json['isRead'] = json['isRead'] ? 1 : 0;
    return json;
  }
}

enum NotificationType {
  //TODO アイコン吟味
  system(icon: Icons.notifications_active_rounded),
  update(icon: Icons.update),
  info(icon: Icons.info),
  warning(icon: Icons.warning),
  other(icon: Icons.more_horiz),
  ;

  final IconData icon;
  const NotificationType({required this.icon});
}

class NotificationTypeEnumConverter
    implements JsonConverter<NotificationType, String> {
  const NotificationTypeEnumConverter();

  @override
  NotificationType fromJson(String json) {
    final NotificationType notificationType =
        NotificationType.values.firstWhere(
      (element) => element.name == json,
      orElse: () => NotificationType.other,
    );
    return notificationType;
  }

  @override
  String toJson(NotificationType object) {
    return object.name;
  }
}
