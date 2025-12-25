import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kenryo_tankyu/core/constants/work/category_value.dart';
import 'package:kenryo_tankyu/features/search/presentation/providers/providers.dart';
import 'package:kenryo_tankyu/features/settings/presentation/providers/settings_providers.dart';

class CategoryList extends ConsumerWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeModeAsync = ref.watch(themeModeProvider);
    final themeMode = themeModeAsync.value ?? ThemeMode.system;
    final notifier = ref.read(searchProvider.notifier);
    return SizedBox(
      width: double.infinity,
      child: GridView.builder(
        itemCount: Category.values.length - 1,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(6.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
              onPressed: () {
                context.push('/subCategory');
                notifier.selectedCategory(Category.values[index]);
                //todo
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Category.values[index].nameForExplore,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: Category.values[index] == Category.other
                        ? themeMode == ThemeMode.dark
                            ? Image.asset(
                                'assets/images/categories/${Category.values[index].name}_for_dark.png',
                                fit: BoxFit.contain,
                              )
                            : Image.asset(
                                'assets/images/categories/${Category.values[index].name}_for_light.png',
                                fit: BoxFit.contain,
                              )
                        : Image.asset(
                            'assets/images/categories/${Category.values[index].name}.png',
                            fit: BoxFit.contain,
                          ),
                  ),
                ],
              ),
            ),
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //横方向のアイテム数を画面の幅によって変える。スマホなら2、タブレットなら3
          crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
          childAspectRatio: 2,
        ),
      ),
    );
  }
}
