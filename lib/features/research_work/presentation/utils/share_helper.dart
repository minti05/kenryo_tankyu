import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:kenryo_tankyu/features/research_work/domain/models/searched.dart';

String buildShareText(Searched searched) {
  final url = 'https://tankyu-app.web.app/result/${searched.documentID}';
  return '『${searched.title}』\n'
      '${searched.enterYear.displayName}年度入学／${searched.course.displayName}\n'
      '名前：${searched.author}\n'
      '---------\n'
      'カテゴリ1：${searched.category1.displayName}>${searched.subCategory1.displayName}\n'
      'カテゴリ2：${searched.category2.displayName}>${searched.subCategory2.displayName}\n'
      '---------\n'
      '$url';
}

Future<void> shareSearched(Searched searched, {BuildContext? context}) async {
  await SharePlus.instance.share(
    ShareParams(
      text: buildShareText(searched),
      // iPadでは共有シートがポップオーバー表示になるため、アンカー位置を渡さないと
      // 何も表示されない。呼び出し元WidgetのRectを基準位置として指定する。
      sharePositionOrigin: _sharePositionOrigin(context),
    ),
  );
}

/// 共有シートのポップオーバー表示用のアンカー位置（iPad向け）を返す。
Rect? _sharePositionOrigin(BuildContext? context) {
  if (context == null) return null;
  final box = context.findRenderObject() as RenderBox?;
  if (box == null || !box.hasSize) return null;
  return box.localToGlobal(Offset.zero) & box.size;
}
