//ユーザーの定数を管理するファイル

enum Affiliation {
  enter2022(displayName: '2022年度入学生', enterYear: 2022),
  enter2023(displayName: '2023年度入学生', enterYear: 2023),
  enter2024(displayName: '2024年度入学生', enterYear: 2024),
  enter2025(displayName: '2025年度入学生', enterYear: 2025),
  enter2026(displayName: '2026年度入学生', enterYear: 2026),

  teacher(displayName: '教職員'),
  developer(displayName: 'デベロッパー'),
  ;

  const Affiliation({required this.displayName, this.enterYear});
  final String displayName;
  final int? enterYear;
}
