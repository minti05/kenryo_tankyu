import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import "package:kenryo_tankyu/core/constants/work/category_value.dart";
import "package:kenryo_tankyu/core/constants/work/sub_category_value.dart";
import 'package:kenryo_tankyu/features/search/presentation/providers/search_provider.dart';


class SearchHeader extends ConsumerStatefulWidget
    implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  const SearchHeader({super.key});

  @override
  ConsumerState createState() => _SearchHeaderState();
}

class _SearchHeaderState extends ConsumerState<SearchHeader> {
  @override
  void initState() {
    super.initState();
    ref.read(searchProvider);
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(searchProvider.notifier);
    final List<String> searchWord = ref.watch(searchProvider).searchWord;
    final controller = TextEditingController(text: searchWord.join(' '));
    return AppBar(
      leading: BackButton(
        onPressed: () {
          //入力が中断された内容を全て削除する
          ref.read(suggestCategoryProvider.notifier).state = Category.none;
          ref.read(suggestSubCategoryProvider.notifier).state = SubCategory.none;
          notifier.deleteAllParameters();
          context.go('/home');
        },
      ),
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
      titleSpacing: 0,
      title: Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: SizedBox(
          height: 40,
          child: Container(
            padding: const EdgeInsets.only(left: 16.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: TextField(
              autofocus: true,
              controller: controller,
              decoration: InputDecoration(
                hintText: 'キーワードを入力',
                suffixIcon: IconButton(
                  onPressed: () => controller.clear(), //リセット処理
                  icon: const Icon(Icons.clear),
                ),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                isDense: true,
              ),
              onSubmitted: (String text) {
                _onSubmitted(text, notifier);
              },
              onChanged: (String text) {
                _onChanged(text);
              },
            ),
          ),
        ),
      ),
    );
  }

  void _onSubmitted(String text, notifier) {
    if (RegExp(r'^\s*$').hasMatch(text)) return; //空白のみの場合は何もしない
    final List<String> word =
        text.replaceAll("　", " ").split(" "); //検索ワードを空白で区切る
    word.removeWhere((content) =>
        content == ' ' ||
        content == '　'); //検索ワードに余分に空白が入っていた場合、消去する todo しっかり機能していないかも。
    notifier.addKeyWord(word);
    //検索結果画面に遷移
    context.pushReplacement('/resultList');
  }

  void _onChanged(String text) {
    //検索ワードがカテゴリ名かサブカテゴリ名があった場合、サジェストとして表示する機能
    final List<Category> categoryList = Category.values;
    final List<SubCategory> subCategoryList = SubCategory.values;
    if (categoryList.any((element) => element.suggestNameList.contains(text))) {
      final Category category = categoryList
          .firstWhere((element) => element.suggestNameList.contains(text));
      debugPrint('category: ${category.displayName}');
      ref.read(suggestCategoryProvider.notifier).state = category;
      //ref.read(searchProvider.notifier).selectedCategory(category);
    } else if (subCategoryList.any((element) => element.suggestNameList.contains(text))) {
      final SubCategory subCategory =
          subCategoryList.firstWhere((element) => element.suggestNameList.contains(text));
      debugPrint('subCategory: ${subCategory.displayName}');
      ref.read(suggestSubCategoryProvider.notifier).state = subCategory;
      //ref.read(searchProvider.notifier).selectedSubCategory(subCategory);
    } else {
      ref.read(suggestSubCategoryProvider.notifier).state = SubCategory.none;
      ref.read(suggestCategoryProvider.notifier).state = Category.none;
    }
  }
}
