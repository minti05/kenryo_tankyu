import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kenryo_tankyu/features/teacher/domain/models/teacher.dart';

import 'package:kenryo_tankyu/features/teacher/presentation/providers/teacher_provider.dart';
import 'package:kenryo_tankyu/features/user_archive/presentation/providers/user_archive_providers.dart';

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
            child: FutureBuilder<Uint8List?>(
              future: _getPdf(ref, selectedTeacher.filename),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    if (snapshot.error
                        .toString()
                        .contains('object-not-found')) {
                      return const Center(
                          child: Text('これから出てくる予定だよ！',
                              style: TextStyle(fontSize: 20.0)));
                    } else {
                      return Center(
                          child: Text('エラーが発生しました。${snapshot.error}'));
                    }
                  }
                  if (snapshot.data == null) {
                    return const Text('データがありません。');
                  }
                  return PDFView(
                    pdfData: snapshot.data!,
                    enableSwipe: true,
                    autoSpacing: true,
                    pageFling: true,
                    pageSnap: false,
                  );
                }
                return const Center(child: CircularProgressIndicator());
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

  Future<Uint8List?> _getPdf(WidgetRef ref, String id) async {
    final repository = ref.read(userArchiveRepositoryProvider);
    return await repository.getTeacherPdf(id);
  }
}
