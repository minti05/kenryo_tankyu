// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'research_work_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(researchWorkRepository)
const researchWorkRepositoryProvider = ResearchWorkRepositoryProvider._();

final class ResearchWorkRepositoryProvider extends $FunctionalProvider<
    ResearchWorkRepository,
    ResearchWorkRepository,
    ResearchWorkRepository> with $Provider<ResearchWorkRepository> {
  const ResearchWorkRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'researchWorkRepositoryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$researchWorkRepositoryHash();

  @$internal
  @override
  $ProviderElement<ResearchWorkRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ResearchWorkRepository create(Ref ref) {
    return researchWorkRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ResearchWorkRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ResearchWorkRepository>(value),
    );
  }
}

String _$researchWorkRepositoryHash() =>
    r'8aa5e121a86b1f0298042dd812c9b9fb46ca1139';
