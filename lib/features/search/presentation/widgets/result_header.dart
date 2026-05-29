import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import "package:kenryo_tankyu/core/constants/work/category_value.dart";
import "package:kenryo_tankyu/core/constants/work/sub_category_value.dart";
import 'package:kenryo_tankyu/features/search/presentation/widgets/search_chip_list.dart';
import 'package:kenryo_tankyu/features/search/presentation/providers/search_provider.dart';

import 'package:kenryo_tankyu/features/search/domain/models/search.dart';

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
            onTap: () => context.pop(),
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
    final Search searchStatus = ref.watch(searchProvider);
    if (searchStatus.subCategory != SubCategory.none) {
      notifier.deleteParameter('subCategory');
    } else if (searchStatus.category != Category.none) {
      notifier.deleteAllParameters();
    }
    context.pop();
  }
}
