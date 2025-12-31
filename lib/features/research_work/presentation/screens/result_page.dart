import 'package:flutter/material.dart';
import 'package:flutter_lazy_indexed_stack/flutter_lazy_indexed_stack.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kenryo_tankyu/features/research_work/domain/models/searched.dart';
import 'package:kenryo_tankyu/features/research_work/presentation/providers/searched_provider.dart';
import 'package:kenryo_tankyu/features/research_work/presentation/screens/pdf_expand_page.dart';
import 'package:kenryo_tankyu/features/research_work/presentation/widgets/header_for_result.dart';
import 'package:kenryo_tankyu/features/research_work/presentation/widgets/work_title.dart';
import 'package:kenryo_tankyu/features/research_work/presentation/widgets/work_details_table.dart';
import 'package:kenryo_tankyu/features/research_work/presentation/widgets/pdf_choice_chip.dart';
import 'package:kenryo_tankyu/features/research_work/presentation/widgets/display_pdf.dart';
import 'package:kenryo_tankyu/presentation/widget/error_view.dart';
import 'package:screen_capture_event/screen_capture_event.dart';

class ResultPage extends ConsumerStatefulWidget {
  final int documentID;
  const ResultPage({super.key, required this.documentID});

  @override
  ConsumerState<ResultPage> createState() => _ResultPageMainState();
}

class _ResultPageMainState extends ConsumerState<ResultPage> {
  final ScreenCaptureEvent screenListener = ScreenCaptureEvent();

  @override
  void initState() {
    super.initState();
    screenListener.addScreenShotListener((filePath) {
      _showAlertDialog();
    });
    Future.delayed(Duration.zero, () {
      screenListener.watch();
    });
  }

  @override
  void dispose() {
    screenListener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(isFullScreenProvider) ? 1 : 0; //全画面表示かどうか
    final AsyncValue<Searched> searched =
        ref.watch(searchedItemProvider(widget.documentID));

    // データがあれば、ローディング中（refresh中）でも元々のコンテンツを表示し続ける
    if (searched.hasValue) {
      final searchedData = searched.requireValue;
      return LazyIndexedStack(
        index: currentIndex,
        children: [
          Scaffold(
            appBar: HeaderForResultPage(searched: searchedData),
            body: Padding(
              padding: const EdgeInsets.only(top: 4.0, left: 8.0, right: 8.0),
              child: Column(children: [
                WorkTitle(searched: searchedData),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: WorkDetailsTable(searched: searchedData),
                ),
                PdfChoiceChip(searched: searchedData),
                DisplayPdf(searched: searchedData),
              ]),
            ),
          ),
          PdfExpandPage(searched: searchedData),
        ],
      );
    }

    return searched.when(
      data: (_) => const SizedBox.shrink(), // すでに上で処理済みだが型合わせのために必要
      loading: () => Scaffold(
        appBar: AppBar(),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => Scaffold(
        appBar: AppBar(),
        body: CommonErrorView(
          error: error,
          onRetry: () =>
              ref.invalidate(searchedItemProvider(widget.documentID)),
        ),
      ),
    );
  }

  void _showAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('⚠️注意⚠ｚ️'),
          content: const Text(
              'スクリーンショットを検知しました。\nプライバシー保護の観点から、第三者に撮った画面を共有しないでください。'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
