import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import "package:kenryo_tankyu/core/constants/feature/user_value.dart";
import 'package:kenryo_tankyu/features/auth/presentation/providers/auth_provider.dart';

class InputYear extends ConsumerWidget {
  const InputYear({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Affiliation> display_item = _displayItem();
    return InputDecorator(
      decoration: InputDecoration(
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          isExpanded: true,
          hint: const Text('選択してください'),
          icon: const Icon(Icons.expand_more),
          borderRadius: BorderRadius.circular(8.0),
          value: ref.watch(authProvider).affiliation,
          items: display_item
              .map<DropdownMenuItem<Affiliation>>((Affiliation value) {
            String name = value.displayName;
            if (value.enterYear != null) {
              final now = DateTime.now();
              final pre = now.month < 4 ? "新" : "";
              final differences = now.year - value.enterYear! + 1;
              switch (differences) {
                case < 1:
                  name = '未来の人';
                  break;
                case < 4:
                  name = '$pre$differences年生($name)';
                  break;
                default:
                  pre == '新' && differences - 3 == 1
                      ? name = '現3年生($name)'
                      : name = '$name（OB・OG${differences - 3}年目）';
              }
            }
            return DropdownMenuItem<Affiliation>(
                value: value, child: Text(name, maxLines: 1));
          }).toList(),
          onChanged: (value) =>
              ref.read(authProvider.notifier).changeAffiliation(value!),
        ),
      ),
    );
  }

  //現在時刻を使用し、今表示されるべきリストに変換する。
  List<Affiliation> _displayItem() {
    List<Affiliation> list = [];
    final value = Affiliation.values;
    final now = DateTime.now();

    for (int i = 0; i < Affiliation.values.length; i++) {
      if (value[i].enterYear != null) {
        final differences = now.year - value[i].enterYear! +1;
        final pre = now.month < 4 ? "新" : "現";
        if (pre == '現'){
          //4月から12月までの対応
          differences >= 1 && differences <= 3 ? list.add(value[i]) : null;
        } else {
          //1月から3月までの対応
          differences >= 2 && differences <= 4 ? list.add(value[i]) : null;
        }
      }
    }

    list.add(Affiliation.teacher);
    list.add(Affiliation.developer);
    return list;
  }
}
