import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import "package:kenryo_tankyu/core/constants/work/category_value.dart";
import "package:kenryo_tankyu/core/constants/work/sub_category_value.dart";
import 'package:kenryo_tankyu/features/search/presentation/providers/search_provider.dart';
import 'package:kenryo_tankyu/presentation/widget/widget.dart';

class SubCategorySelectHeader extends ConsumerWidget implements PreferredSizeWidget {
  //探索からカテゴリを選び、サブカテゴリ検索画面にいった時にのみ、ここに値が入っている
  final String categoryWord;


  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  const SubCategorySelectHeader({super.key, required this.categoryWord});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      leading: BackButton(
        onPressed: () {
          ref.read(suggestCategoryProvider.notifier).state = Category.none;
          ref.read(suggestSubCategoryProvider.notifier).state = SubCategory.none;
          ref.read(searchProvider.notifier).deleteAllParameters();
          ref.read(footerProvider.notifier).state = 1;
          context.go('/explore');
        },
      ),
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
      titleSpacing:  0.0, 
      title: Padding(
        padding: EdgeInsets.only(
            right: 16.0),
        child: SizedBox(
          height: 40,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(padding: EdgeInsets.only(left: 16)),
                const Icon(Icons.search),
                const Padding(padding: EdgeInsets.only(left: 12)),
                Text(
                  'カテゴリ...$categoryWord',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
