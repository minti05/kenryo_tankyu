import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:kenryo_tankyu/core/providers/firebase_providers.dart';
import 'package:kenryo_tankyu/features/research_work/domain/models/models.dart';
import 'package:kenryo_tankyu/features/research_work/presentation/providers/providers.dart';
import 'package:kenryo_tankyu/features/user_archive/data/datasources/datasources.dart';

///ボタン連打防止を管理するProvider
final ableChangeFavoriteProvider =
    StateProvider.autoDispose<bool>((ref) => true);

///documentIDごとにfavoriteかどうかを記録するProvider。
final userIsFavoriteStateProvider = AsyncNotifierProvider.family<ChangeFavoriteNotifier, bool, int>(
  ChangeFavoriteNotifier.new,
);

class ChangeFavoriteNotifier extends AsyncNotifier<bool> {
  ChangeFavoriteNotifier(this.param);
  final int param;

  @override
  Future<bool> build() async {
    final initialState = await SearchedHistoryController.instance
        .getFavoriteState(this.param);
    return initialState;
  }

  Future<void> changeIsFavorite(int documentID, bool nowFavoriteState) async {
    final bool newFavoriteState = !nowFavoriteState;
    //dbの更新
    await SearchedHistoryController.instance
        .changeFavoriteState(documentID, newFavoriteState);
    //firestoreの更新
    final firestore = ref.read(firebaseFirestoreProvider)
        .collection('works')
        .doc(documentID.toString());
    if (newFavoriteState) {
      await firestore.update({
        'exactLikes': FieldValue.increment(1),
        'vagueLikes': FieldValue.increment(1)
      });
    } else {
      await firestore.update({
        'exactLikes': FieldValue.increment(-1),
        'vagueLikes': FieldValue.increment(-1)
      });
    }
    state = AsyncData(newFavoriteState);
  }
}

///ResultPageのFavoriteボタン。(Widget)
class FavoriteForResultPage extends ConsumerStatefulWidget {
  final Searched searched;
  const FavoriteForResultPage({super.key, required this.searched});

  @override
  ConsumerState<FavoriteForResultPage> createState() =>
      _FavoriteForResultPageState();
}

class _FavoriteForResultPageState extends ConsumerState<FavoriteForResultPage> {
  late int likes;

  @override
  void initState() {
    super.initState();
    debugPrint("現在のlikesは${widget.searched.vagueLikes}");
    likes = widget.searched.vagueLikes;
  }

  Widget build(BuildContext context) {
    final searched = widget.searched;
    final ableChangeFavorite = ref.watch(ableChangeFavoriteProvider);
    final ableChangeFavoriteNotifier =
        ref.read(ableChangeFavoriteProvider.notifier);
    final isFavorite =
        ref.watch(userIsFavoriteStateProvider(searched.documentID)).asData?.value ?? false;

    //強制リロードをした時に、likesの値を更新している。initStateだとリロード時に反映されないため。
    ref.listen<AsyncValue<Searched>>(
        getFirestoreSearchedProvider(searched.documentID), (previous, next) {
      next.whenData((searched) {
        setState(() {
          likes = searched.vagueLikes;
        });
      });
    });

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
            color: isFavorite
                ? Colors.red
                : Theme.of(context).colorScheme.onSurface),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(children: [
        IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite
                ? Colors.red
                : Theme.of(context).colorScheme.onSurface,
          ),
          onPressed: () async {
            if (ableChangeFavorite) {
              ableChangeFavoriteNotifier.state = false; //ボタン連打防止
              ref
                  .read(
                      userIsFavoriteStateProvider(searched.documentID).notifier)
                  .changeIsFavorite(searched.documentID, isFavorite);
              setState(() {
                likes = isFavorite ? likes - 1 : likes + 1;
              });
              await Future.delayed(const Duration(seconds: 2));
              if (context.mounted) {
                ableChangeFavoriteNotifier.state = true; //ボタン連打防止
              }
            } else {
              const snackBar = SnackBar(
                  content: Text('データ保存中です。'),
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 1));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
        ),
        const SizedBox(height: 4),
        searched.isCached
            ? const SizedBox()
            : Text(
                likes.toString(),
                style: TextStyle(
                    color: isFavorite
                        ? Colors.red
                        : Theme.of(context).colorScheme.onSurface),
              ),
      ]),
    );
  }
}

class FavoriteForResultListPage extends ConsumerWidget {
  final Searched searched;
  const FavoriteForResultListPage({super.key, required this.searched});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite =
        ref.watch(userIsFavoriteStateProvider(searched.documentID)).asData?.value ?? false;

    return Column(children: [
      Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color:
            isFavorite ? Colors.red : Theme.of(context).colorScheme.onSurface,
      ),
      searched.isCached
          ? const SizedBox()
          : Text(
              searched.vagueLikes.toString(),
              style: TextStyle(
                  color: isFavorite
                      ? Colors.red
                      : Theme.of(context).colorScheme.onSurface),
            ),
    ]);
  }
}

class FavoriteForHistory extends ConsumerWidget {
  final Searched searched;
  const FavoriteForHistory({super.key, required this.searched});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite =
        ref.watch(userIsFavoriteStateProvider(searched.documentID)).asData?.value ?? false;
    return IconButton(
      icon: isFavorite
          ? const Icon(Icons.favorite, color: Colors.red)
          : const Icon(Icons.favorite_border, color: Colors.red),
      onPressed: () async {
        ref
            .read(userIsFavoriteStateProvider(searched.documentID).notifier)
            .changeIsFavorite(searched.documentID, isFavorite);
      },
    );
  }
}
