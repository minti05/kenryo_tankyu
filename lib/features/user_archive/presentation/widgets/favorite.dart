import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kenryo_tankyu/features/research_work/domain/models/searched.dart';
import 'package:kenryo_tankyu/features/research_work/presentation/providers/searched_provider.dart';
import 'package:kenryo_tankyu/features/user_archive/presentation/providers/user_archive_providers.dart';

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

    likes = widget.searched.vagueLikes;
  }

  Widget build(BuildContext context) {
    final searched = widget.searched;

    final isFavorite = ref
            .watch(userIsFavoriteStateProvider(searched.documentID))
            .asData
            ?.value ??
        false;

    //強制リロードをした時に、likesの値を更新している。initStateだとリロード時に反映されないため。
    ref.listen<AsyncValue<Searched>>(searchedItemProvider(searched.documentID),
        (previous, next) {
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
            final notifier = ref.read(
                userIsFavoriteStateProvider(searched.documentID).notifier);
            final success =
                await notifier.toggle(searched.documentID, isFavorite);

            if (success) {
              setState(() {
                likes = isFavorite ? likes - 1 : likes + 1;
              });
            } else {
              if (context.mounted) {
                const snackBar = SnackBar(
                    content: Text('データ保存中です。'),
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 1));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
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
    final isFavorite = ref
            .watch(userIsFavoriteStateProvider(searched.documentID))
            .asData
            ?.value ??
        false;

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
    final isFavorite = ref
            .watch(userIsFavoriteStateProvider(searched.documentID))
            .asData
            ?.value ??
        false;
    return IconButton(
      icon: isFavorite
          ? const Icon(Icons.favorite, color: Colors.red)
          : const Icon(Icons.favorite_border, color: Colors.red),
      onPressed: () async {
        final notifier =
            ref.read(userIsFavoriteStateProvider(searched.documentID).notifier);
        final success = await notifier.toggle(searched.documentID, isFavorite);
        if (!success && context.mounted) {
          const snackBar = SnackBar(
              content: Text('データ保存中です。'),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 1));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
    );
  }
}
