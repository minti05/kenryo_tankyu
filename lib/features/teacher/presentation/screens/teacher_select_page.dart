import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kenryo_tankyu/core/constants/work/search_value.dart';
import 'package:kenryo_tankyu/features/teacher/presentation/providers/teacher_provider.dart';

class TeacherSelectPage extends ConsumerWidget {
  const TeacherSelectPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(selectedTeacherProvider.notifier);
    final sortedTeacherList = ref.watch(teacherSortedListProvider);
    final sortedType = ref.watch(sortedTypeForTeacherProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('縣陵先生図鑑'),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return SortTypeForTeacher.values
                  .map((e) => PopupMenuItem(
                        onTap: () {
                          ref
                              .read(teacherSortedListProvider.notifier)
                              .sortList(e);
                          ref
                              .read(sortedTypeForTeacherProvider.notifier)
                              .state = e;
                        },
                        value: e,
                        child: Text(e.name),
                      ))
                  .toList();
            },
            icon: const Icon(Icons.sort),
          ),
        ],
      ),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            trailing: const Icon(Icons.navigate_next),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${sortedTeacherList[index].name} 先生'),
                Chip(
                    avatar: CircleAvatar(
                      backgroundColor:
                          sortedType == SortTypeForTeacher.gradeOrder
                              ? sortedTeacherList[index].gradeInCharge.color
                              : sortedTeacherList[index].subject.color,
                    ),
                    label: Text(sortedType == SortTypeForTeacher.gradeOrder
                        ? sortedTeacherList[index].gradeInCharge.name
                        : sortedTeacherList[index].subject.name)),
              ],
            ),
            onTap: () {
              notifier.state = sortedTeacherList[index];
              if (!context.mounted) return;
              context.push('/teacher/showPdf');
            },
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Divider(
              height: 3,
              color: Colors.grey,
            ),
          );
        },
        itemCount: sortedTeacherList.length,
      ),
    );
  }
}
