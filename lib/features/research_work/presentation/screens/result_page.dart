import 'package:flutter/material.dart';
import 'package:flutter_lazy_indexed_stack/flutter_lazy_indexed_stack.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kenryo_tankyu/features/research_work/domain/models/searched.dart';
import 'package:kenryo_tankyu/features/research_work/presentation/providers/searched_provider.dart';
import 'package:kenryo_tankyu/features/research_work/presentation/screens/pdf_expand_page.dart';
import 'package:kenryo_tankyu/features/research_work/presentation/utils/share_helper.dart';
import 'package:kenryo_tankyu/features/research_work/presentation/widgets/header_for_result.dart';
import 'package:kenryo_tankyu/features/research_work/presentation/widgets/work_info_section.dart';
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
  ProviderSubscription<AsyncValue<Searched>>? _staleCheckSub;
  bool _isDetailsExpanded = true;

  @override
  void initState() {
    super.initState();
    screenListener.addScreenShotListener((filePath) {
      _showAlertDialog();
    });
    Future.delayed(Duration.zero, () {
      screenListener.watch();
    });

    // listenManual + fireImmediately: true で、キャッシュ済みの場合も含めて
    // loading → data 遷移を一度だけ検知して陳腐化チェックを実行する。
    // WidgetRef.listen は fireImmediately 非対応のためここで登録する。
    _staleCheckSub = ref.listenManual(
      researchWorkProvider(widget.documentID),
      (prev, next) {
        if (prev?.hasValue != true && next.hasValue) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              ref
                  .read(researchWorkProvider(widget.documentID).notifier)
                  .refreshIfStale();
            }
          });
        }
      },
      fireImmediately: true,
    );
  }

  @override
  void dispose() {
    _staleCheckSub?.close();
    screenListener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // likes のバックグラウンド更新中はスナックバーを表示する
    ref.listen(isRefreshingLikesProvider(widget.documentID), (prev, next) {
      if (!context.mounted) return;
      final messenger = ScaffoldMessenger.of(context);
      if (next) {
        messenger.showSnackBar(
          const SnackBar(
            content: Text('データが古いため更新しています...'),
            duration: Duration(seconds: 30),
            behavior: SnackBarBehavior.floating,
          ),
        );
      } else if (prev == true) {
        messenger.clearSnackBars();
      }
    });

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
                WorkTitle(
                  searched: searchedData,
                  isDetailsExpanded: _isDetailsExpanded,
                  onToggleDetails: () =>
                      setState(() => _isDetailsExpanded = !_isDetailsExpanded),
                ),
                AnimatedSize(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  alignment: Alignment.topCenter,
                  child: _isDetailsExpanded
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 4.0),
                          child: WorkDetailsTable(searched: searchedData),
                        )
                      : const SizedBox.shrink(),
                ),
                PdfChoiceChip(searched: searchedData),
                DisplayPdf(
                  searched: searchedData,
                  onPdfTapped: () {
                    if (_isDetailsExpanded) {
                      setState(() => _isDetailsExpanded = false);
                    }
                  },
                ),
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
    if (!mounted) return;
    final searchedAsync = ref.read(searchedItemProvider(widget.documentID));
    final searched = searchedAsync.hasValue ? searchedAsync.requireValue : null;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('⚠️注意⚠️'),
          content: const Text(
              'スクリーンショットを検知しました。\nプライバシー保護の観点から、第三者に撮った画面を共有しないでください。'),
          actions: [
            if (searched != null)
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  await shareSearched(searched);
                },
                child: const Text('代わりに共有する...'),
              ),
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
