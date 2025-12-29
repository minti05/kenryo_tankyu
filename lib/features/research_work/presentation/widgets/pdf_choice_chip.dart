import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import "package:kenryo_tankyu/core/constants/work/info_value.dart";
import 'package:kenryo_tankyu/features/research_work/domain/models/searched.dart';
import 'package:kenryo_tankyu/features/research_work/presentation/providers/searched_provider.dart';



class PdfChoiceChip extends ConsumerWidget {
  final Searched searched;
  const PdfChoiceChip({super.key, required this.searched});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stringProviderNotifier = ref.read(stringProvider.notifier);
    final isSameScreen = ref.watch(isSameScreenProvider);
    final isSameScreenNotifier = ref.read(isSameScreenProvider.notifier);
    final partOfId = searched.documentID.toString().substring(0, 7);
    final List<DocumentType> list = [];
    if (searched.existsSlide) list.add(DocumentType.slide);
    if (searched.existsReport) list.add(DocumentType.report);
    if (searched.existsPoster) list.add(DocumentType.poster);
    if (searched.existsThesis) list.add(DocumentType.thesis);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isSameScreen) return;
      if(list.isEmpty){
        stringProviderNotifier.state = '$partOfId${DocumentType.slide.idSuffix}';
      } else {
        stringProviderNotifier.state = '$partOfId${list[0].idSuffix}';
      }
      isSameScreenNotifier.state = true;
    }); //最初に表示されるpdfのidを決定

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: list.map((choice) {
          return Consumer(builder: (context, ref, child) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: ChoiceChip(
                showCheckmark: false,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                label: Text(choice.displayName),
                selected: list.indexOf(choice) == ref.watch(intProvider),
                onSelected: (bool selected) {
                  if (!selected) return; //同じチップを押した場合はなにもしない
                  ref.read(intProvider.notifier).state = list.indexOf(choice);
                  stringProviderNotifier.state = '$partOfId${choice.idSuffix}';
                },
              ),
            );
          });
        }).toList(),
      ),
    );
  }
}
