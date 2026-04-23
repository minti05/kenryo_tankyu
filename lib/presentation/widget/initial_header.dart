import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InitialHeader extends StatelessWidget implements PreferredSizeWidget {
  //探索からカテゴリを選び、サブカテゴリ検索画面にいった時にのみ、ここに値が入っている
  final String? categoryWord;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  const InitialHeader({super.key, this.categoryWord});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
      titleSpacing: categoryWord?.isEmpty == null ? 20.0 : 0.0, //？が
      title: Padding(
        padding:
            EdgeInsets.only(right: categoryWord?.isEmpty == null ? 0.0 : 16.0),
        child: SizedBox(
          height: 40,
          child: InkWell(
            onTap: () =>
                categoryWord?.isEmpty == null ? context.push('/search') : null,
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
                    categoryWord?.isEmpty == null
                        ? 'キーワードを検索'
                        : 'カテゴリ...$categoryWord',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
