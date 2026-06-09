import 'package:flutter/material.dart';
import 'package:kenryo_tankyu/core/constants/feature_value.dart';
import 'package:kenryo_tankyu/features/research_work/domain/models/searched.dart';
import 'package:kenryo_tankyu/features/research_work/presentation/widgets/suggest_report/cannot_view_pdf_form.dart';
import 'package:kenryo_tankyu/features/research_work/presentation/widgets/suggest_report/edit_category_form.dart';
import 'package:kenryo_tankyu/features/research_work/presentation/widgets/suggest_report/edit_work_info_form.dart';
import 'package:kenryo_tankyu/features/research_work/presentation/widgets/suggest_report/other_reason_form.dart';

class SuggestReportDialog extends ModalRoute<void> {
  final Searched searched;
  SuggestReportDialog(this.searched);

  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);
  @override
  bool get opaque => false;
  @override
  bool get barrierDismissible => true;
  @override
  Color get barrierColor => Colors.black.withValues(alpha: 0.2);
  @override
  String get barrierLabel => 'SuggestReportDialog';
  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return Center(
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          width: 300,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox.shrink(),
                  const Text('情報の変更を提案', style: TextStyle(fontSize: 18)),
                  IconButton(
                    icon: const Icon(Icons.close, size: 20),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              _SuggestReportForm(searched),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(opacity: animation, child: child);
  }
}

class _SuggestReportForm extends StatefulWidget {
  final Searched searched;
  const _SuggestReportForm(this.searched);

  @override
  State<_SuggestReportForm> createState() => _SuggestReportFormState();
}

class _SuggestReportFormState extends State<_SuggestReportForm> {
  ChangeInfoFromUserType? _selected;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(labelText: '理由'),
          selectedItemBuilder: (context) {
            final maxWidth = MediaQuery.sizeOf(context).width - 70;
            return ChangeInfoFromUserType.values.map((item) {
              return ConstrainedBox(
                constraints: BoxConstraints(minWidth: 200, maxWidth: maxWidth),
                child: Text(item.displayName, overflow: TextOverflow.ellipsis),
              );
            }).toList();
          },
          onChanged: (value) {
            if (value == null) return;
            setState(() {
              _selected = ChangeInfoFromUserType.values
                  .firstWhere((e) => e.displayName == value);
            });
          },
          initialValue: _selected?.displayName,
          hint: const Text('選択してください'),
          items: [
            for (final item in ChangeInfoFromUserType.values)
              DropdownMenuItem(
                value: item.displayName,
                child: Text(item.displayName),
              ),
          ],
        ),
        const SizedBox(height: 16),
        switch (_selected) {
          ChangeInfoFromUserType.editCategory =>
            EditCategoryForm(searched: widget.searched),
          ChangeInfoFromUserType.editWorkInfo =>
            EditWorkInfoForm(searched: widget.searched),
          ChangeInfoFromUserType.cannotViewPdf =>
            CannotViewPdfForm(searched: widget.searched),
          ChangeInfoFromUserType.otherReason =>
            OtherReasonForm(searched: widget.searched),
          null => const SizedBox.shrink(),
        },
        const SizedBox(height: 8),
      ],
    );
  }
}
