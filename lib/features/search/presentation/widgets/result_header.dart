import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kenryo_tankyu/core/constants/work/category_value.dart';
import 'package:kenryo_tankyu/core/constants/work/info_value.dart';
import 'package:kenryo_tankyu/core/constants/work/sub_category_value.dart';
import 'package:kenryo_tankyu/features/search/domain/models/search.dart';
import 'package:kenryo_tankyu/features/search/presentation/providers/algolia_provider.dart';
import 'package:kenryo_tankyu/features/search/presentation/providers/search_provider.dart';

class ResultHeader extends ConsumerStatefulWidget
    implements PreferredSizeWidget {
  const ResultHeader({required this.onOpenFilters, super.key});

  final Future<void> Function() onOpenFilters;

  @override
  Size get preferredSize => const Size.fromHeight(104);

  @override
  ConsumerState<ResultHeader> createState() => _ResultHeaderState();
}

class _ResultHeaderState extends ConsumerState<ResultHeader> {
  late final TextEditingController _controller;
  late final FocusNode _keywordFocusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: ref.read(searchProvider).searchWord.join(' '),
    );
    _keywordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _controller.dispose();
    _keywordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final search = ref.watch(searchProvider);
    final keyword = search.searchWord.join(' ');
    if (_controller.text != keyword && !_keywordFocusNode.hasFocus) {
      _controller.value = TextEditingValue(
        text: keyword,
        selection: TextSelection.collapsed(offset: keyword.length),
      );
    }
    final conditions = _conditionLabels(search);

    return AppBar(
      toolbarHeight: widget.preferredSize.height,
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
      leadingWidth: 48,
      titleSpacing: 0,
      leading: BackButton(onPressed: () => context.pop()),
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 36,
              child: TextField(
                controller: _controller,
                focusNode: _keywordFocusNode,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: 'キーワードを入力',
                  filled: true,
                  fillColor:
                      Theme.of(context).colorScheme.surfaceContainerHighest,
                  prefixIcon: const Icon(Icons.search),
                  prefixIconConstraints:
                      const BoxConstraints.tightFor(width: 40, height: 36),
                  suffixIcon: IconButton(
                    onPressed: () => _controller.clear(),
                    icon: const Icon(Icons.clear),
                    tooltip: '入力を消去',
                  ),
                  suffixIconConstraints:
                      const BoxConstraints.tightFor(width: 40, height: 36),
                  contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onSubmitted: _applyKeyword,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              height: 36,
              child: Material(
                color: Theme.of(context).colorScheme.surfaceContainer,
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  onTap: widget.onOpenFilters,
                  borderRadius: BorderRadius.circular(10),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.tune_rounded,
                          size: 17,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: conditions.isEmpty
                              ? Text(
                                  'フィルターを追加',
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                    fontSize: 13,
                                  ),
                                )
                              : SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: conditions
                                        .map(
                                          (condition) => Padding(
                                            padding: const EdgeInsets.only(
                                                right: 16),
                                            child: Text(
                                              condition,
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSurface,
                                                fontSize: 13,
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                        ),
                        Icon(
                          Icons.chevron_right_rounded,
                          size: 18,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _applyKeyword(String text) {
    final keywords = text
        .replaceAll('　', ' ')
        .split(RegExp(r'\s+'))
        .where((word) => word.isNotEmpty)
        .toList();
    ref.read(searchProvider.notifier).addKeyWord(keywords);
    ref.invalidate(algoliaSearchProvider);
  }

  List<String> _conditionLabels(Search search) {
    final labels = <String>[];
    if (search.subCategory != SubCategory.none) {
      labels.add('カテゴリ: ${search.subCategory.displayName}');
    } else if (search.category != Category.none) {
      labels.add('カテゴリ: ${search.category.displayName}');
    }
    if (search.enterYear != EnterYear.undefined) {
      labels.add('入学年度: ${search.enterYear.label}');
    }
    if (search.course != Course.undefined) {
      labels.add('学科: ${search.course.displayName}');
    }
    return labels;
  }
}
