// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'krgp_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Firestoreから全KRGP受賞作品を1度だけ取得してキャッシュする

@ProviderFor(krgpAwards)
final krgpAwardsProvider = KrgpAwardsProvider._();

/// Firestoreから全KRGP受賞作品を1度だけ取得してキャッシュする

final class KrgpAwardsProvider extends $FunctionalProvider<
        AsyncValue<List<Searched>>, List<Searched>, FutureOr<List<Searched>>>
    with $FutureModifier<List<Searched>>, $FutureProvider<List<Searched>> {
  /// Firestoreから全KRGP受賞作品を1度だけ取得してキャッシュする
  KrgpAwardsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'krgpAwardsProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$krgpAwardsHash();

  @$internal
  @override
  $FutureProviderElement<List<Searched>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Searched>> create(Ref ref) {
    return krgpAwards(ref);
  }
}

String _$krgpAwardsHash() => r'602632ca1f1b6310f05c72241ec5d356edfc3667';
