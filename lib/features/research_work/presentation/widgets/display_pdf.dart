import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kenryo_tankyu/features/research_work/domain/models/searched.dart';
import 'package:kenryo_tankyu/features/research_work/presentation/providers/searched_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:kenryo_tankyu/features/user_archive/presentation/providers/user_archive_providers.dart';

class DisplayPdf extends ConsumerWidget {
  final Searched searched;
  const DisplayPdf({super.key, required this.searched});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Consumer(builder: (context, ref, child) {
            final nowWatchingPdf = ref.watch(stringProvider);
            final pdfAsync =
                ref.watch(pdfProvider(nowWatchingPdf, searched.enterYear));

            return pdfAsync.when(
              data: (pdfData) {
                if (pdfData == null) {
                  return const Center(child: Text('データがありません。'));
                }
                return Stack(
                  children: [
                    PDFView(
                      pdfData: pdfData,
                      enableSwipe: true,
                      autoSpacing: true,
                      pageFling: false,
                      pageSnap: false,
                    ),
                    Consumer(builder: (context, ref, child) {
                      final showFullScreen =
                          ref.watch(showFullScreenButtonProvider);
                      final notifier =
                          ref.read(showFullScreenButtonProvider.notifier);
                      return GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          notifier.state = !showFullScreen;
                        },
                        child: const SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      );
                    })
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) =>
                  Center(child: Text('PDFの取得中にエラーが発生しました: $error')),
            );
          }),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer(builder: (context, ref, child) {
                final showFullScreen = ref.watch(showFullScreenButtonProvider);
                final isFullScreen = ref.watch(isFullScreenProvider);
                return GestureDetector(
                  onTap: () => ref.read(isFullScreenProvider.notifier).state =
                      !isFullScreen,
                  child: AnimatedOpacity(
                    opacity: showFullScreen ? 1 : 0,
                    duration: const Duration(milliseconds: 150),
                    child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35.0),
                        ),
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: Icon(
                            isFullScreen
                                ? Icons.fullscreen_exit
                                : Icons.fullscreen,
                            size: 19,
                          ),
                        )),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
