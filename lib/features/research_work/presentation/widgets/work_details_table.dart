import 'package:flutter/material.dart';
import "package:kenryo_tankyu/core/constants/app_unique_value.dart";
import "package:kenryo_tankyu/core/constants/work/category_value.dart";
import "package:kenryo_tankyu/core/constants/work/info_value.dart";
import "package:kenryo_tankyu/core/constants/work/sub_category_value.dart";
import 'package:kenryo_tankyu/features/research_work/domain/models/searched.dart';

class WorkDetailsTable extends StatelessWidget {
  final Searched searched;
  const WorkDetailsTable({super.key, required this.searched});
  String get author => developer_mode ? 'サンプル' : searched.author;

  @override
  Widget build(BuildContext context) {
    final enterYearText = searched.enterYear == EnterYear.undefined
        ? ''
        : '${searched.enterYear.displayName}年入学 ';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4.0, bottom: 8.0),
          child: Text(
            '$enterYearText${searched.course.displayName} ／ $author',
            style: TextStyle(
              fontSize: 13,
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withValues(alpha: 0.6),
            ),
          ),
        ),
        Row(
          children: [
            _CategoryChip(
              category: searched.category1,
              subCategory: searched.subCategory1,
            ),
            if (searched.category2 != Category.none) ...[
              const SizedBox(width: 8),
              _CategoryChip(
                category: searched.category2,
                subCategory: searched.subCategory2,
              ),
            ],
          ],
        ),
      ],
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final Category category;
  final SubCategory subCategory;

  const _CategoryChip({required this.category, required this.subCategory});

  String? _imagePath(bool isDark) {
    const imageDir = 'assets/images/categories/';
    const validNames = {
      'history',
      'rights',
      'international',
      'business',
      'education',
      'science',
      'technology',
      'health',
      'art',
      'life',
      'society',
    };
    if (category == Category.other) {
      return isDark
          ? '${imageDir}other_for_dark.png'
          : '${imageDir}other_for_light.png';
    }
    if (validNames.contains(category.name)) {
      return '$imageDir${category.name}.png';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final imagePath = _imagePath(isDark);
    final color = category.color;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (imagePath != null) ...[
            Image.asset(imagePath, width: 22, height: 22),
            const SizedBox(width: 6),
          ],
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                category.displayName,
                style: TextStyle(
                  fontSize: 10,
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                subCategory.displayName,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
