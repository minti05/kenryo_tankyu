import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kenryo_tankyu/core/providers/firebase_providers.dart';
import 'package:kenryo_tankyu/features/research_work/domain/models/searched.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'research_work_data_source.g.dart';

abstract class ResearchWorkDataSource {
  Future<Searched> fetchWork(String documentID);
}

class ResearchWorkDataSourceImpl implements ResearchWorkDataSource {
  ResearchWorkDataSourceImpl(this._firestore);
  final FirebaseFirestore _firestore;

  @override
  Future<Searched> fetchWork(String documentID) async {
    final serverSnapshot =
        await _firestore.collection('works').doc(documentID).get();
    // Note: isFavorite defaults to false here, to be handled by repository/notifier
    return Searched.fromFirestore(serverSnapshot, false);
  }
}

@riverpod
ResearchWorkDataSource researchWorkDataSource(Ref ref) {
  final firestore = ref.watch(firebaseFirestoreProvider);
  return ResearchWorkDataSourceImpl(firestore);
}
