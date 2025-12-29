sealed class AuthFailure implements Exception {
  const AuthFailure();
}

class InvalidEmail extends AuthFailure {
  const InvalidEmail();
}

class WrongPassword extends AuthFailure {
  const WrongPassword();
}

class UserNotFound extends AuthFailure {
  const UserNotFound();
}

class EmailAlreadyInUse extends AuthFailure {
  const EmailAlreadyInUse();
}

class WeakPassword extends AuthFailure {
  const WeakPassword();
}

class RequiresRecentLogin extends AuthFailure {
  const RequiresRecentLogin();
}

class UnknownAuthFailure extends AuthFailure {
  final String? message;
  final String? code;
  const UnknownAuthFailure({this.message, this.code});
}
