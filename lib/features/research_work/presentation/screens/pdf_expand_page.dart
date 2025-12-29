import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kenryo_tankyu/features/research_work/domain/models/searched.dart';
import 'package:kenryo_tankyu/features/research_work/presentation/providers/searched_provider.dart';
import 'package:kenryo_tankyu/features/research_work/presentation/widgets/display_pdf.dart';
import 'package:kenryo_tankyu/features/research_work/presentation/widgets/pdf_choice_chip.dart';

class PdfExpandPage extends ConsumerWidget {
  final Searched searched;
  const PdfExpandPage({super.key, required this.searched});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFullScreen = ref.watch(isFullScreenProvider);
    return PopScope(
      onPopInvokedWithResult: (popInvoked, result) {
        if (isFullScreen) {
          ref.read(isFullScreenProvider.notifier).state = false;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: PdfChoiceChip(searched: searched),
        ),
        body: Column(children: [
          DisplayPdf(searched: searched),
        ]),
      ),
    );
  }
}
