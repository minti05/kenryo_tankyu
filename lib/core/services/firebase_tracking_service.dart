import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

class FirebaseTrackingService {
  static final FirebaseCrashlytics _crashlytics = FirebaseCrashlytics.instance;
  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  /// アプリ起動時に呼ぶ。Flutter/Platformエラーを Crashlytics に流す。
  static Future<void> initialize() async {
    await _crashlytics.setCrashlyticsCollectionEnabled(!kDebugMode);

    FlutterError.onError = (FlutterErrorDetails details) {
      if (kDebugMode) {
        FlutterError.presentError(details);
      } else {
        _crashlytics.recordFlutterFatalError(details);
      }
    };

    PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
      if (kDebugMode) {
        // デバッグ時は Crashlytics に送らず、エラーをコンソールへ流す
        return false;
      }
      _crashlytics.recordError(error, stack, fatal: true);
      return true;
    };
  }

  /// ログイン中ユーザーのメールアドレスを Crashlytics に紐付ける。
  /// ログアウト時は null を渡してクリアする。
  static Future<void> setUserEmail(String? email) async {
    await _crashlytics.setUserIdentifier(email ?? '');
    await _analytics.setUserId(id: email);
  }

  /// PDFが Storage に存在しない (object-not-found) エラーを記録する。
  static void logPdfNotFound({
    required int documentId,
    required String pdfPath,
  }) {
    _crashlytics.log('PDF not found: documentId=$documentId path=$pdfPath');
    _analytics.logEvent(
      name: 'pdf_not_found',
      parameters: {
        'document_id': documentId,
        'pdf_path': pdfPath,
      },
    );
  }

  /// ログイン失敗を記録する（連続失敗が閾値以上のときだけ呼ぶ想定）。
  static void logAuthFailure({
    required String method,
    required String errorCode,
    required String errorMessage,
    required int failureCount,
  }) {
    _crashlytics.log(
      'Auth failure #$failureCount: method=$method code=$errorCode message=$errorMessage',
    );
    _analytics.logEvent(
      name: 'auth_failure',
      parameters: {
        'method': method,
        'error_code': errorCode,
        'failure_count': failureCount,
      },
    );
  }

  /// 任意の非致命的エラーを Crashlytics に記録する。
  static void recordError(
    Object error,
    StackTrace? stack, {
    String? reason,
    bool fatal = false,
  }) {
    _crashlytics.recordError(error, stack, reason: reason, fatal: fatal);
  }
}
