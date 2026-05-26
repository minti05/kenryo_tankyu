//アプリの中の各機能のconstを管理するファイル

enum ChangeInfoFromUserType {
  editCategory(displayName: 'カテゴリの分類が不適切'),
  editWorkInfo(displayName: '作品の情報が間違っている'),
  cannotViewPdf(displayName: 'PDFが閲覧できない'),
  otherReason(displayName: 'その他'),
  ;

  const ChangeInfoFromUserType({required this.displayName});
  final String displayName;
}
