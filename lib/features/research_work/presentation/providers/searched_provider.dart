import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:kenryo_tankyu/core/providers/firebase_providers.dart';
import 'package:kenryo_tankyu/features/research_work/domain/models/models.dart';
import 'package:kenryo_tankyu/features/user_archive/data/datasources/datasources.dart';


//全画面表示ボタンを表示するかしないかを管理するprovider
final showFullScreenButtonProvider =
    StateProvider.autoDispose<bool>((ref) => true);

//全画面か詳細画面かどうかを管理するprovider。IndexedStackに使用
final isFullScreenProvider = StateProvider.autoDispose<bool>((ref) => false);

//同じ探究作品を見ている最中なのかどうかを管理するprovider
//このproviderを導入することによって、全画面に切り替えたときに不用意な再ビルドを防ぐ。
final isSameScreenProvider = StateProvider.autoDispose<bool>((ref) => false);

final forceReloadProvider = StateProvider.autoDispose<bool>((ref) => false);

//作品データを取得するProvider
final getFirestoreSearchedProvider =
    FutureProvider.family.autoDispose<Searched, int>((ref, documentID) async {
  final firestore = ref.watch(firebaseFirestoreProvider);
  final forceReload = ref.read(forceReloadProvider); //ref.readなのは、このforceReloadが変更されてもこのproviderが自動的に発火しないようにするため。
  if (forceReload) {
    debugPrint("強制リロードするよー");
    final serverSnapshot =
        await firestore.collection('works').doc(documentID.toString()).get();
    final isFavorite =
        await SearchedHistoryController.instance.getFavoriteState(documentID);
    final data = Searched.fromFirestore(serverSnapshot, isFavorite);

    debugPrint("取得データ　${data.toString()}");
    ref.read(forceReloadProvider.notifier).state = false;
    //firestoreから取得した時のみ、履歴に追加
    SearchedHistoryController.instance.insertHistory(data);
    return data.copyWith(isCached: false);
  } else {
    final Searched? data =
        await SearchedHistoryController.instance.getHistory(documentID);
    if (data != null) {
      debugPrint("キャッシュデータだよー ${data.toString()}");
      return data;
    } else {
      final serverSnapshot =
          await firestore.collection('works').doc(documentID.toString()).get();
      final isFavorite =
          await SearchedHistoryController.instance.getFavoriteState(documentID);
      final data = Searched.fromFirestore(serverSnapshot, isFavorite);
      SearchedHistoryController.instance.insertHistory(data);
      return data;
    }
  }
});

//choiceChipの選択肢を管理する簡易的なProvider
final intProvider = StateProvider.autoDispose((ref) => 0);
final stringProvider =
    StateProvider.autoDispose<String>((ref) => '22202363'); //TODO 初期値これ升田さんのやつ。
