// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_history_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SearchHistoryCache)
const searchHistoryCacheProvider = SearchHistoryCacheProvider._();

final class SearchHistoryCacheProvider
    extends $AsyncNotifierProvider<SearchHistoryCache, List<Search>?> {
  const SearchHistoryCacheProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'searchHistoryCacheProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$searchHistoryCacheHash();

  @$internal
  @override
  SearchHistoryCache create() => SearchHistoryCache();
}

String _$searchHistoryCacheHash() =>
    r'255fd3a7e018fbebd7df5d79fc3fd55290551337';

abstract class _$SearchHistoryCache extends $AsyncNotifier<List<Search>?> {
  FutureOr<List<Search>?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<Search>?>, List<Search>?>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<Search>?>, List<Search>?>,
        AsyncValue<List<Search>?>,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
