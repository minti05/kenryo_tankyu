import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kenryo_tankyu/features/teacher/domain/models/teacher.dart';

import 'package:kenryo_tankyu/features/teacher/presentation/providers/teacher_provider.dart';
import 'package:kenryo_tankyu/features/user_archive/presentation/providers/user_archive_providers.dart';
import 'package:kenryo_tankyu/core/error/failures.dart';
import 'package:kenryo_tankyu/presentation/widget/error_view.dart';

class ShowTeacherPdfPage extends ConsumerWidget {
  const ShowTeacherPdfPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Teacher selectedTeacher = ref.watch(selectedTeacherProvider);
    final List<Teacher> sortedTeacherList =
        ref.watch(teacherSortedListProvider);
    final int selectedIndex = sortedTeacherList.indexOf(selectedTeacher);

    final Teacher beforeTeacher = selectedIndex == 0
        ? sortedTeacherList.last
        : sortedTeacherList[selectedIndex - 1];

    final Teacher afterTeacher = selectedIndex == sortedTeacherList.length - 1
        ? sortedTeacherList.first
        : sortedTeacherList[selectedIndex + 1];

    return Scaffold(
      appBar: AppBar(title: Text('${selectedTeacher.name} 先生')),
      body: Column(
        children: [
          Expanded(
            child: ref.watch(teacherPdfProvider(selectedTeacher.filename)).when(
                  data: (data) {
                    if (data == null) {
                      return const Center(child: Text('データがありません。'));
                    }
                    return PDFView(
                      pdfData: data,
                      enableSwipe: true,
                      autoSpacing: true,
                      pageFling: true,
                      pageSnap: false,
                    );
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, stack) {
                    if (error is ServerFailure &&
                        error.code == 'object-not-found') {
                      return const Center(
                          child: Text('これから出てくる予定だよ！',
                              style: TextStyle(fontSize: 20.0)));
                    }
                    return CommonErrorView(
                      error: error,
                      onRetry: () => ref.invalidate(
                          teacherPdfProvider(selectedTeacher.filename)),
                    );
                  },
                ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton.icon(
                onPressed: () {
                  ref.read(selectedTeacherProvider.notifier).state =
                      beforeTeacher;
                },
                icon: const Icon(Icons.arrow_back),
                label: Text('${beforeTeacher.name}先生')),
            TextButton.icon(
                iconAlignment: IconAlignment.end,
                onPressed: () {
                  ref.read(selectedTeacherProvider.notifier).state =
                      afterTeacher;
                },
                icon: const Icon(Icons.arrow_forward),
                label: Text('${afterTeacher.name}先生')),
          ],
        ),
      ),
    );
  }
}
