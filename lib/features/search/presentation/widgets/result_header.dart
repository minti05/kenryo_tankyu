import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import "package:kenryo_tankyu/core/constants/work/category_value.dart";
import "package:kenryo_tankyu/core/constants/work/sub_category_value.dart";
import 'package:kenryo_tankyu/features/search/presentation/widgets/search_chip_list.dart';
import 'package:kenryo_tankyu/features/search/presentation/providers/search_provider.dart';

import 'package:kenryo_tankyu/features/search/domain/models/search.dart';
import 'package:kenryo_tankyu/presentation/widget/widget.dart';

class ResultHeader extends ConsumerStatefulWidget
    implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  const ResultHeader({super.key});

  @override
  ResultHeaderState createState() => ResultHeaderState();
}

class ResultHeaderState extends ConsumerState<ResultHeader> {
  @override
  void initState() {
    super.initState();
    ref.read(searchProvider);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [Container()],

      ///drawerを開くボタンを消している
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
      titleSpacing: 0,
      leading: BackButton(
        onPressed: () => _backTo(context),
      ),
      title: Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: SizedBox(
          height: 40,
          child: InkWell(
            onTap: () => context.pushReplacement('/search'),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 16),
                  Icon(Icons.search),
                  SizedBox(width: 8),
                  Expanded(child: SearchChipList(true)),
                  SizedBox(width: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _backTo(BuildContext context) {
    final notifier = ref.read(searchProvider.notifier);
    final footerNotifier = ref.read(footerProvider.notifier);
    final Search searchStatus = ref.watch(searchProvider);
    //優先順位は上から順
    //ユーザーが入力した単語が入っている場合→キーワード入力画面(/search)まで戻る
    //サブカテゴリーが入っている場合→サブカテゴリ選択画面(/subCategory)まで戻る
    //カテゴリのみ選択されている場合→カテゴリ選択画面(/explore)まで戻る
    if (searchStatus.searchWord.isNotEmpty) {
      context.go('/search');
    } else if (searchStatus.subCategory != SubCategory.none) {
      notifier.deleteParameter('subCategory');
      context.go('/subCategory');
    } else if (searchStatus.category != Category.none) {
      notifier.deleteAllParameters();
      footerNotifier.state = 1;
      context.go('/explore');
    } else {
      footerNotifier.state = 0;
      context.go('/home');
    }
  }
}
