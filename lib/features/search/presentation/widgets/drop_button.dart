import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import "package:kenryo_tankyu/core/constants/work/info_value.dart";
import "package:kenryo_tankyu/core/constants/work/category_value.dart";
import 'package:kenryo_tankyu/features/search/presentation/providers/search_provider.dart';

class SearchDropButton extends ConsumerWidget {
  const SearchDropButton(
      {required this.name,
      this.selectedText,
      required this.choices,
      super.key});
  final String name;
  final String? selectedText;
  final List<String> choices;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Flexible(
            flex: 1,
            child:
                Container(alignment: Alignment.centerRight, child: Text(name))),
        const SizedBox(width: 8.0),
        Flexible(
          flex: 2,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                isExpanded: true,
                icon: const Icon(Icons.expand_more),
                borderRadius: BorderRadius.circular(8.0),
                hint: const Text('指定なし'),
                value: selectedText,
                items: choices.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(),
                onChanged: (value) => _onChanged(value, ref),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _onChanged(String? value, WidgetRef ref) {
    final notifier = ref.read(searchProvider.notifier);
    final selectedValue = value ?? '';

    switch (name) {
      case '期間':
        notifier.selectedYear(EnterYear.values.firstWhere(
            (element) => element.displayName.toString() == selectedValue,
            orElse: () => EnterYear.undefined));
        break;
      case 'イベント名':
        notifier.selectedEventName(EventName.values.firstWhere(
            (element) => element.displayName == selectedValue,
            orElse: () => EventName.undefined));
        break;
      case '学科指定':
        notifier.selectedCourse(Course.values.firstWhere(
            (element) => element.displayName == selectedValue,
            orElse: () => Course.undefined));
        break;
      default:
        notifier.selectedCategory(Category.values.firstWhere(
            (element) => element.displayName == selectedValue,
            orElse: () => Category.none));
        break;
    }
  }
}
