import 'package:kenryo_tankyu/core/error/failures.dart';

sealed class AuthFailure extends Failure {
  const AuthFailure(String message) : super(message);
}

class InvalidEmail extends AuthFailure {
  const InvalidEmail() : super('メールアドレスの形式が正しくありません。');
}

class WrongPassword extends AuthFailure {
  const WrongPassword() : super('パスワードが正しくありません。');
}

class UserNotFound extends AuthFailure {
  const UserNotFound() : super('ユーザーが見つかりません。');
}

class EmailAlreadyInUse extends AuthFailure {
  const EmailAlreadyInUse() : super('このメールアドレスはすでに使用されています。');
}

class WeakPassword extends AuthFailure {
  const WeakPassword() : super('パスワードが簡単すぎます。より複雑なパスワードを設定してください。');
}

class RequiresRecentLogin extends AuthFailure {
  const RequiresRecentLogin() : super('セキュリティのため、もう一度ログインしてください。');
}

class UnknownAuthFailure extends AuthFailure {
  final String? code;
  const UnknownAuthFailure({String? message, this.code})
      : super(message ?? '予期せぬエラーが発生しました。');
}

class NotRegisteredUser extends AuthFailure {
  const NotRegisteredUser()
      : super(
            'このGoogleアカウントは縣陵探究アーカイブに登録されていません。\n縣陵の@kenryo.ed.jpアカウントでサインインしてください。');
}

class GoogleSignInCancelled extends AuthFailure {
  const GoogleSignInCancelled() : super('Googleサインインがキャンセルされました。');
}
