// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_archive_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(userArchiveRepository)
const userArchiveRepositoryProvider = UserArchiveRepositoryProvider._();

final class UserArchiveRepositoryProvider extends $FunctionalProvider<
    UserArchiveRepository,
    UserArchiveRepository,
    UserArchiveRepository> with $Provider<UserArchiveRepository> {
  const UserArchiveRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'userArchiveRepositoryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$userArchiveRepositoryHash();

  @$internal
  @override
  $ProviderElement<UserArchiveRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  UserArchiveRepository create(Ref ref) {
    return userArchiveRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserArchiveRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserArchiveRepository>(value),
    );
  }
}

String _$userArchiveRepositoryHash() =>
    r'ec9aad0acb1c898be49fc89adeef8038e52dfd5d';

/// ボタン連打防止を管理するProvider

@ProviderFor(AbleChangeFavorite)
const ableChangeFavoriteProvider = AbleChangeFavoriteProvider._();

/// ボタン連打防止を管理するProvider
final class AbleChangeFavoriteProvider
    extends $NotifierProvider<AbleChangeFavorite, bool> {
  /// ボタン連打防止を管理するProvider
  const AbleChangeFavoriteProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'ableChangeFavoriteProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$ableChangeFavoriteHash();

  @$internal
  @override
  AbleChangeFavorite create() => AbleChangeFavorite();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$ableChangeFavoriteHash() =>
    r'1a195da3eeeedc2d1c59a5b85e861a1e2adeece9';

/// ボタン連打防止を管理するProvider

abstract class _$AbleChangeFavorite extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<bool, bool>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<bool, bool>, bool, Object?, Object?>;
    element.handleValue(ref, created);
  }
}

/// documentIDごとにfavoriteかどうかを記録するProvider

@ProviderFor(UserIsFavoriteState)
const userIsFavoriteStateProvider = UserIsFavoriteStateFamily._();

/// documentIDごとにfavoriteかどうかを記録するProvider
final class UserIsFavoriteStateProvider
    extends $AsyncNotifierProvider<UserIsFavoriteState, bool> {
  /// documentIDごとにfavoriteかどうかを記録するProvider
  const UserIsFavoriteStateProvider._(
      {required UserIsFavoriteStateFamily super.from,
      required int super.argument})
      : super(
          retry: null,
          name: r'userIsFavoriteStateProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$userIsFavoriteStateHash();

  @override
  String toString() {
    return r'userIsFavoriteStateProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  UserIsFavoriteState create() => UserIsFavoriteState();

  @override
  bool operator ==(Object other) {
    return other is UserIsFavoriteStateProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$userIsFavoriteStateHash() =>
    r'33648334b276454917e6e58713a01374b5442170';

/// documentIDごとにfavoriteかどうかを記録するProvider

final class UserIsFavoriteStateFamily extends $Family
    with
        $ClassFamilyOverride<UserIsFavoriteState, AsyncValue<bool>, bool,
            FutureOr<bool>, int> {
  const UserIsFavoriteStateFamily._()
      : super(
          retry: null,
          name: r'userIsFavoriteStateProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// documentIDごとにfavoriteかどうかを記録するProvider

  UserIsFavoriteStateProvider call(
    int documentID,
  ) =>
      UserIsFavoriteStateProvider._(argument: documentID, from: this);

  @override
  String toString() => r'userIsFavoriteStateProvider';
}

/// documentIDごとにfavoriteかどうかを記録するProvider

abstract class _$UserIsFavoriteState extends $AsyncNotifier<bool> {
  late final _$args = ref.$arg as int;
  int get documentID => _$args;

  FutureOr<bool> build(
    int documentID,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(
      _$args,
    );
    final ref = this.ref as $Ref<AsyncValue<bool>, bool>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<bool>, bool>,
        AsyncValue<bool>,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}

@ProviderFor(searchedHistory)
const searchedHistoryProvider = SearchedHistoryFamily._();

final class SearchedHistoryProvider extends $FunctionalProvider<
        AsyncValue<List<Searched>?>, List<Searched>?, FutureOr<List<Searched>?>>
    with $FutureModifier<List<Searched>?>, $FutureProvider<List<Searched>?> {
  const SearchedHistoryProvider._(
      {required SearchedHistoryFamily super.from, required bool super.argument})
      : super(
          retry: null,
          name: r'searchedHistoryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$searchedHistoryHash();

  @override
  String toString() {
    return r'searchedHistoryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Searched>?> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Searched>?> create(Ref ref) {
    final argument = this.argument as bool;
    return searchedHistory(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is SearchedHistoryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$searchedHistoryHash() => r'fd22fd316566e36e9625f532e610097f8e1a7382';

final class SearchedHistoryFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Searched>?>, bool> {
  const SearchedHistoryFamily._()
      : super(
          retry: null,
          name: r'searchedHistoryProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  SearchedHistoryProvider call(
    bool onlyShowFavorite,
  ) =>
      SearchedHistoryProvider._(argument: onlyShowFavorite, from: this);

  @override
  String toString() => r'searchedHistoryProvider';
}
