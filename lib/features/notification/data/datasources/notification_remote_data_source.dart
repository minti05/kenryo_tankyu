import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kenryo_tankyu/core/providers/firebase_providers.dart';
import 'package:kenryo_tankyu/features/notification/domain/models/notification_content.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_remote_data_source.g.dart';

abstract class NotificationRemoteDataSource {
  Future<List<NotificationContent>> fetchLatestNotifications();
}

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  NotificationRemoteDataSourceImpl(this._firestore);
  final FirebaseFirestore _firestore;

  @override
  Future<List<NotificationContent>> fetchLatestNotifications() async {
    final snapshot = await _firestore
        .collection('notifications')
        .orderBy('sendAt', descending: true)
        .limit(4)
        .get(const GetOptions(source: Source.server));
    return snapshot.docs
        .map((doc) => NotificationContent.fromJson(doc.data()))
        .toList();
  }
}

@riverpod
NotificationRemoteDataSource notificationRemoteDataSource(Ref ref) {
  final firestore = ref.watch(firebaseFirestoreProvider);
  return NotificationRemoteDataSourceImpl(firestore);
}
