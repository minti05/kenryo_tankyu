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
    r'0cc9ca50197c441d2241527354e8fb97cf3d3d4f';

@ProviderFor(FavoriteIdsCache)
const favoriteIdsCacheProvider = FavoriteIdsCacheProvider._();

final class FavoriteIdsCacheProvider
    extends $AsyncNotifierProvider<FavoriteIdsCache, Set<int>> {
  const FavoriteIdsCacheProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'favoriteIdsCacheProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$favoriteIdsCacheHash();

  @$internal
  @override
  FavoriteIdsCache create() => FavoriteIdsCache();
}

String _$favoriteIdsCacheHash() => r'6d9b76398c88e8734def2b30944d92564c8a068b';

abstract class _$FavoriteIdsCache extends $AsyncNotifier<Set<int>> {
  FutureOr<Set<int>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<Set<int>>, Set<int>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<Set<int>>, Set<int>>,
        AsyncValue<Set<int>>,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}

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

@ProviderFor(UserIsFavoriteState)
const userIsFavoriteStateProvider = UserIsFavoriteStateFamily._();

final class UserIsFavoriteStateProvider
    extends $AsyncNotifierProvider<UserIsFavoriteState, bool> {
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
    r'f2756f3f96e88d606957700f9a7be88d089bf311';

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

  UserIsFavoriteStateProvider call(
    int documentID,
  ) =>
      UserIsFavoriteStateProvider._(argument: documentID, from: this);

  @override
  String toString() => r'userIsFavoriteStateProvider';
}

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

String _$searchedHistoryHash() => r'73fc7538c5477eef98cc6742da99d5c74c9700af';

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

@ProviderFor(HistoryController)
const historyControllerProvider = HistoryControllerProvider._();

final class HistoryControllerProvider
    extends $NotifierProvider<HistoryController, void> {
  const HistoryControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'historyControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$historyControllerHash();

  @$internal
  @override
  HistoryController create() => HistoryController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$historyControllerHash() => r'56f12497211c6200902c5cab557b7b0a7b0f6ee6';

abstract class _$HistoryController extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    build();
    final ref = this.ref as $Ref<void, void>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<void, void>, void, Object?, Object?>;
    element.handleValue(ref, null);
  }
}

@ProviderFor(PdfCacheController)
const pdfCacheControllerProvider = PdfCacheControllerProvider._();

final class PdfCacheControllerProvider
    extends $NotifierProvider<PdfCacheController, void> {
  const PdfCacheControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'pdfCacheControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$pdfCacheControllerHash();

  @$internal
  @override
  PdfCacheController create() => PdfCacheController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$pdfCacheControllerHash() =>
    r'969f3994bf6af81a592ef9af351753dd9dffcf07';

abstract class _$PdfCacheController extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    build();
    final ref = this.ref as $Ref<void, void>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<void, void>, void, Object?, Object?>;
    element.handleValue(ref, null);
  }
}

@ProviderFor(pdf)
const pdfProvider = PdfFamily._();

final class PdfProvider extends $FunctionalProvider<AsyncValue<Uint8List?>,
        Uint8List?, FutureOr<Uint8List?>>
    with $FutureModifier<Uint8List?>, $FutureProvider<Uint8List?> {
  const PdfProvider._(
      {required PdfFamily super.from,
      required (
        String,
        EnterYear,
      )
          super.argument})
      : super(
          retry: null,
          name: r'pdfProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$pdfHash();

  @override
  String toString() {
    return r'pdfProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<Uint8List?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Uint8List?> create(Ref ref) {
    final argument = this.argument as (
      String,
      EnterYear,
    );
    return pdf(
      ref,
      argument.$1,
      argument.$2,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is PdfProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$pdfHash() => r'e8b84067365598b0b1df27f7834970290ee121d5';

final class PdfFamily extends $Family
    with
        $FunctionalFamilyOverride<
            FutureOr<Uint8List?>,
            (
              String,
              EnterYear,
            )> {
  const PdfFamily._()
      : super(
          retry: null,
          name: r'pdfProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  PdfProvider call(
    String id,
    EnterYear enterYear,
  ) =>
      PdfProvider._(argument: (
        id,
        enterYear,
      ), from: this);

  @override
  String toString() => r'pdfProvider';
}

@ProviderFor(teacherPdf)
const teacherPdfProvider = TeacherPdfFamily._();

final class TeacherPdfProvider extends $FunctionalProvider<
        AsyncValue<Uint8List?>, Uint8List?, FutureOr<Uint8List?>>
    with $FutureModifier<Uint8List?>, $FutureProvider<Uint8List?> {
  const TeacherPdfProvider._(
      {required TeacherPdfFamily super.from, required String super.argument})
      : super(
          retry: null,
          name: r'teacherPdfProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$teacherPdfHash();

  @override
  String toString() {
    return r'teacherPdfProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Uint8List?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Uint8List?> create(Ref ref) {
    final argument = this.argument as String;
    return teacherPdf(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is TeacherPdfProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$teacherPdfHash() => r'057e15f2884799ab0241d6aacd45317bb29b587f';

final class TeacherPdfFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Uint8List?>, String> {
  const TeacherPdfFamily._()
      : super(
          retry: null,
          name: r'teacherPdfProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  TeacherPdfProvider call(
    String id,
  ) =>
      TeacherPdfProvider._(argument: id, from: this);

  @override
  String toString() => r'teacherPdfProvider';
}
