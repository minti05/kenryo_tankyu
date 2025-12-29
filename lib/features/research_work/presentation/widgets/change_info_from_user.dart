import 'package:flutter/material.dart';
import 'package:kenryo_tankyu/core/constants/feature_value.dart';
import 'package:kenryo_tankyu/features/research_work/domain/models/searched.dart';
import 'package:kenryo_tankyu/features/research_work/presentation/widgets/cannot_view_pdf.dart';
import 'package:kenryo_tankyu/features/research_work/presentation/widgets/edit_category.dart';
import 'package:kenryo_tankyu/features/research_work/presentation/widgets/edit_work_info.dart';
import 'package:kenryo_tankyu/features/research_work/presentation/widgets/other_reason.dart';

class ChangeInfoFromUser extends StatefulWidget {
  final Searched searched;
  const ChangeInfoFromUser(this.searched, {super.key});

  @override
  _ChangeInfoFromUserState createState() => _ChangeInfoFromUserState();
}

class _ChangeInfoFromUserState extends State<ChangeInfoFromUser> {
  ChangeInfoFromUserType? selected;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      DropdownButtonFormField(
        decoration: const InputDecoration(
          labelText: '理由',
        ),
        selectedItemBuilder: (context) {
          // 調整がシビア
          final maxWidth = MediaQuery.sizeOf(context).width - 70;
          return ChangeInfoFromUserType.values.map((item) {
            return ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 200,
                maxWidth: maxWidth,
              ),
              child: Text(
                item.displayName,
                overflow: TextOverflow.ellipsis,
              ),
            );
          }).toList();
        },
        onChanged: (value) {
          setState(() {
            selected = ChangeInfoFromUserType.values.firstWhere(
              (element) => element.displayName == value,
            );
          });
        },
        initialValue: selected?.displayName,
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
      (() {
        switch (selected) {
          case ChangeInfoFromUserType.editCategory:
            return EditCategory(searched: widget.searched);
          case ChangeInfoFromUserType.editWorkInfo:
            return EditWorkInfo(searched: widget.searched);
          case ChangeInfoFromUserType.cannotViewPdf:
            return CannotViewPdf();
          case ChangeInfoFromUserType.otherReason:
            return OtherReason();
          default:
            return const SizedBox();
        }
      })(),
      const SizedBox(height: 8),
    ]);
  }
}
