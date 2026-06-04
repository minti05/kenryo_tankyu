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

Future<void> shareSearched(Searched searched) async {
  await SharePlus.instance.share(
    ShareParams(text: buildShareText(searched)),
  );
}
