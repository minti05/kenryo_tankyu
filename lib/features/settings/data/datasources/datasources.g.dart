// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datasources.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(settingsDataSource)
const settingsDataSourceProvider = SettingsDataSourceProvider._();

final class SettingsDataSourceProvider extends $FunctionalProvider<
    SettingsDataSource,
    SettingsDataSource,
    SettingsDataSource> with $Provider<SettingsDataSource> {
  const SettingsDataSourceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'settingsDataSourceProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$settingsDataSourceHash();

  @$internal
  @override
  $ProviderElement<SettingsDataSource> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SettingsDataSource create(Ref ref) {
    return settingsDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SettingsDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SettingsDataSource>(value),
    );
  }
}

String _$settingsDataSourceHash() =>
    r'0573753c6a3c131df954b07e74eace08dc486b8d';
