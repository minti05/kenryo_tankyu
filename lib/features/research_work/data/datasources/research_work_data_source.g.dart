// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'research_work_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(researchWorkDataSource)
const researchWorkDataSourceProvider = ResearchWorkDataSourceProvider._();

final class ResearchWorkDataSourceProvider extends $FunctionalProvider<
    ResearchWorkDataSource,
    ResearchWorkDataSource,
    ResearchWorkDataSource> with $Provider<ResearchWorkDataSource> {
  const ResearchWorkDataSourceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'researchWorkDataSourceProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$researchWorkDataSourceHash();

  @$internal
  @override
  $ProviderElement<ResearchWorkDataSource> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ResearchWorkDataSource create(Ref ref) {
    return researchWorkDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ResearchWorkDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ResearchWorkDataSource>(value),
    );
  }
}

String _$researchWorkDataSourceHash() =>
    r'b29d8cfbd91621c647626e04e08023ca979d6859';
