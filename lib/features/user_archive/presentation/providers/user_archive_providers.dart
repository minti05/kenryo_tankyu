import 'package:kenryo_tankyu/features/user_archive/data/repositories/repositories.dart';
import 'package:kenryo_tankyu/features/user_archive/domain/repositories/repositories.dart';
import 'package:kenryo_tankyu/core/providers/firebase_providers.dart';
import 'package:kenryo_tankyu/features/user_archive/data/datasources/pdf_db.dart';
import 'package:kenryo_tankyu/features/user_archive/data/datasources/recommended_works_db.dart';
import 'package:kenryo_tankyu/features/user_archive/data/datasources/searched_history_db.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_archive_providers.g.dart';

@riverpod
UserArchiveRepository userArchiveRepository(Ref ref) {
  final historyDataSource = ref.watch(searchedHistoryDataSourceProvider);
  final pdfDataSource = ref.watch(pdfDbDataSourceProvider);
  final recommendedDataSource = ref.watch(recommendedWorksDataSourceProvider);
  final firestore = ref.watch(firebaseFirestoreProvider);
  
  return UserArchiveRepositoryImpl(
    historyDataSource,
    pdfDataSource,
    recommendedDataSource,
    firestore,
  );
}

/// ボタン連打防止を管理するProvider
@riverpod
class AbleChangeFavorite extends _$AbleChangeFavorite {
  @override
  bool build() => true;

  void set(bool value) => state = value;
}

/// documentIDごとにfavoriteかどうかを記録するProvider
@riverpod
class UserIsFavoriteState extends _$UserIsFavoriteState {
  @override
  Future<bool> build(int documentID) async {
    final repository = ref.watch(userArchiveRepositoryProvider);
    return repository.getFavoriteState(documentID);
  }

  Future<void> changeIsFavorite(int documentID, bool nowFavoriteState) async {
    final bool newFavoriteState = !nowFavoriteState;
    final repository = ref.read(userArchiveRepositoryProvider);
    
    // Repository handles both local DB and remote Firestore updates
    await repository.changeFavoriteState(documentID, newFavoriteState);
    
    state = AsyncData(newFavoriteState);
    // Invalidate history provider so list updates
    ref.invalidate(searchedHistoryProvider);
  }
}

@riverpod
Future<List<Searched>?> searchedHistory(Ref ref, bool onlyShowFavorite) async {
  final repository = ref.watch(userArchiveRepositoryProvider);
  if (onlyShowFavorite) {
    return repository.getFavoriteHistory();
  } else {
    return repository.getAllHistory();
  }
}
