import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'connectivity_provider.g.dart';

@riverpod
Stream<List<ConnectivityResult>> connectivity(Ref ref) {
  return Connectivity().onConnectivityChanged;
}

@riverpod
bool isConnected(Ref ref) {
  final connectivitySync = ref.watch(connectivityProvider);
  return connectivitySync.maybeWhen(
    data: (results) =>
        results.any((result) => result != ConnectivityResult.none),
    orElse: () => true, // デフォルトは接続済みとみなす
  );
}
