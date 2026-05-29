import 'package:flutter_riverpod/legacy.dart';

/// ディープリンクで起動されたとき、未ログインの場合に元のパスを一時保存するProvider。
/// ログイン完了後にこのパスへリダイレクトし、その後nullに戻す。
final deepLinkPathProvider = StateProvider<String?>((ref) => null);
