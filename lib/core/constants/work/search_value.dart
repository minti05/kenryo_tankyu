//検索画面の条件分岐を管理するファイル

enum SortType { newOrder, oldOrder, likeOrder }

extension SortTypeExtension on SortType {
  String get displayName {
    switch (this) {
      case SortType.newOrder:
        return '新しい順';
      case SortType.oldOrder:
        return '古い順';
      case SortType.likeOrder:
        return 'いいね順';
    }
  }
}

enum SortTypeForTeacher {
  nameAscendingOrder,
  nameDescendingOrder,
  subjectOrder,
  gradeOrder
}

extension SortTypeForTeacherExtension on SortTypeForTeacher {
  String get name {
    switch (this) {
      case SortTypeForTeacher.nameAscendingOrder:
        return '50音順';
      case SortTypeForTeacher.nameDescendingOrder:
        return '逆50音順';
      case SortTypeForTeacher.subjectOrder:
        return '教科順';
      case SortTypeForTeacher.gradeOrder:
        return '学年順';
    }
  }
}
