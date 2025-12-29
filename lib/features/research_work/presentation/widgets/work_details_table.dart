import 'package:flutter/material.dart';
import "package:kenryo_tankyu/core/constants/app_unique_value.dart";
import "package:kenryo_tankyu/core/constants/work/category_value.dart";
import 'package:kenryo_tankyu/features/research_work/domain/models/searched.dart';

class WorkDetailsTable extends StatelessWidget {
  final Searched searched;
  const WorkDetailsTable({super.key, required this.searched});
  String get author => developer_mode ? 'サンプル' : searched.author;

  @override
  Widget build(BuildContext context) {
    return Table(
      border: const TableBorder.symmetric(
          inside: BorderSide(width: 1, color: Colors.grey)),
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(5),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        TableRow(children: [
          const Center(
              child: Text('学科 ／ 名前', style: TextStyle(color: Colors.grey))),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
            child: Text('${searched.course.displayName} ／ ${author}',
                style: const TextStyle(fontSize: 16)),
          ),
        ]),
        TableRow(children: [
          const Center(
              child: Text('カテゴリ1', style: TextStyle(color: Colors.grey))),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
            child: Text(
                '${searched.category1.displayName} > ${searched.subCategory1.displayName}',
                style: const TextStyle(fontSize: 16)),
          ),
        ]),
        if (searched.category2 != Category.none)
          TableRow(children: [
            const Center(
                child: Text('カテゴリ2', style: TextStyle(color: Colors.grey))),
            Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
              child: Text(
                  '${searched.category2.displayName} > ${searched.subCategory2.displayName}',
                  style: const TextStyle(fontSize: 16)),
            ),
          ]),
      ],
    );
  }
}
