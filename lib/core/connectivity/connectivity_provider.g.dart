// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connectivity_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(connectivity)
const connectivityProvider = ConnectivityProvider._();

final class ConnectivityProvider extends $FunctionalProvider<
        AsyncValue<List<ConnectivityResult>>,
        List<ConnectivityResult>,
        Stream<List<ConnectivityResult>>>
    with
        $FutureModifier<List<ConnectivityResult>>,
        $StreamProvider<List<ConnectivityResult>> {
  const ConnectivityProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'connectivityProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$connectivityHash();

  @$internal
  @override
  $StreamProviderElement<List<ConnectivityResult>> $createElement(
          $ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<ConnectivityResult>> create(Ref ref) {
    return connectivity(ref);
  }
}

String _$connectivityHash() => r'69c6e2db8337a9ff832358c4a079a4846fa6f28c';

@ProviderFor(isConnected)
const isConnectedProvider = IsConnectedProvider._();

final class IsConnectedProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  const IsConnectedProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'isConnectedProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$isConnectedHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return isConnected(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isConnectedHash() => r'2a70184c41fefe3e01892efe80261d10126ec690';
