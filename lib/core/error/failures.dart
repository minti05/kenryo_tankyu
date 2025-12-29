/// エラー情報を保持する抽象クラス
/// すべてのエラー（Failure）はこのクラスを継承します。
sealed class Failure implements Exception {
  final String message;
  const Failure(this.message);

  @override
  String toString() => message;
}

/// ネットワーク接続に関するエラー
class NetworkFailure extends Failure {
  const NetworkFailure({String message = 'インターネットに接続できませんでした。'})
      : super(message);
}

/// ローカルデータベースに関するエラー
class DatabaseFailure extends Failure {
  const DatabaseFailure({String message = 'データの保存または読み込みに失敗しました。'})
      : super(message);
}

/// サーバー（Firestore, API等）に関するエラー
class ServerFailure extends Failure {
  final String? code;
  const ServerFailure({
    String message = 'サーバーでエラーが発生しました。時間をおいて再度お試しください。',
    this.code,
  }) : super(message);
}

/// 予期せぬエラー
class UnknownFailure extends Failure {
  const UnknownFailure({String message = '予期せぬエラーが発生しました。'}) : super(message);
}
