import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kenryo_tankyu/core/constants/work/category_value.dart';
import 'package:kenryo_tankyu/core/constants/work/info_value.dart';
import 'package:kenryo_tankyu/core/constants/work/sub_category_value.dart';
import 'package:kenryo_tankyu/features/search/domain/models/search.dart';

/// Opens the filter as an editable draft. The caller applies the returned
/// conditions only after the user explicitly taps the search button.
Future<Search?> showSearchFilterSheet(BuildContext context, Search initial) {
  return showModalBottomSheet<Search>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (_) => FractionallySizedBox(
      heightFactor: 0.82,
      child: SearchFilterSheet(initial: initial),
    ),
  );
}

class SearchFilterSheet extends ConsumerStatefulWidget {
  const SearchFilterSheet({required this.initial, super.key});

  final Search initial;

  @override
  ConsumerState<SearchFilterSheet> createState() => _SearchFilterSheetState();
}

class _SearchFilterSheetState extends ConsumerState<SearchFilterSheet> {
  late final TextEditingController _keywordController;
  late Search _draft;

  @override
  void initState() {
    super.initState();
    _draft = widget.initial;
    _keywordController =
        TextEditingController(text: _draft.searchWord.join(' '));
  }

  @override
  void dispose() {
    _keywordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    return Material(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 8, 4),
            child: Row(
              children: [
                const Expanded(
                  child: Text('絞り込み', style: TextStyle(fontSize: 20)),
                ),
                TextButton(
                  onPressed: _clear,
                  child: const Text('条件をクリア'),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                  tooltip: '閉じる',
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(16, 20, 16, bottomInset + 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _keywordController,
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      labelText: 'キーワード検索',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                  const SizedBox(height: 24),
                  _sectionTitle('カテゴリ'),
                  DropdownButtonFormField<Category>(
                    value: _draft.category,
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
                    items: Category.values
                        .map((category) => DropdownMenuItem(
                              value: category,
                              child: Text(category.displayName),
                            ))
                        .toList(),
                    onChanged: (category) {
                      if (category == null) return;
                      setState(() {
                        _draft = _draft.copyWith(
                          category: category,
                          subCategory: SubCategory.none,
                        );
                      });
                    },
                  ),
                  if (_draft.category != Category.none) ...[
                    const SizedBox(height: 24),
                    _sectionTitle('サブカテゴリ'),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children:
                          _draft.category.subCategories.map((subCategory) {
                        return ChoiceChip(
                          label: Text(subCategory.displayName),
                          selected: _draft.subCategory == subCategory,
                          onSelected: (selected) => setState(() {
                            _draft = _draft.copyWith(
                              subCategory:
                                  selected ? subCategory : SubCategory.none,
                            );
                          }),
                        );
                      }).toList(),
                    ),
                  ],
                  const SizedBox(height: 24),
                  _sectionTitle('入学年度'),
                  DropdownButtonFormField<EnterYear>(
                    value: _draft.enterYear,
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
                    items: EnterYear.values
                        .map((year) => DropdownMenuItem(
                              value: year,
                              child: Text(year.label),
                            ))
                        .toList(),
                    onChanged: (year) {
                      if (year != null)
                        setState(
                            () => _draft = _draft.copyWith(enterYear: year));
                    },
                  ),
                  const SizedBox(height: 24),
                  _sectionTitle('学科'),
                  DropdownButtonFormField<Course>(
                    value: _draft.course,
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
                    items: Course.values
                        .map((course) => DropdownMenuItem(
                              value: course,
                              child: Text(course.displayName),
                            ))
                        .toList(),
                    onChanged: (course) {
                      if (course != null)
                        setState(
                            () => _draft = _draft.copyWith(course: course));
                    },
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: _apply,
                      icon: const Icon(Icons.search),
                      label: const Text('再検索する'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
      );

  void _clear() {
    setState(() {
      _draft = _draft.copyWith(
        category: Category.none,
        subCategory: SubCategory.none,
        enterYear: EnterYear.undefined,
        course: Course.undefined,
        eventName: EventName.undefined,
        searchWord: [],
      );
      _keywordController.clear();
    });
  }

  void _apply() {
    final keywords = _keywordController.text
        .replaceAll('　', ' ')
        .split(RegExp(r'\s+'))
        .where((word) => word.isNotEmpty)
        .toList();
    Navigator.of(context).pop(_draft.copyWith(searchWord: keywords));
  }
}
