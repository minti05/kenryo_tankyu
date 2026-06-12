// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'searched_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ResearchWork)
final researchWorkProvider = ResearchWorkFamily._();

final class ResearchWorkProvider
    extends $AsyncNotifierProvider<ResearchWork, Searched> {
  ResearchWorkProvider._(
      {required ResearchWorkFamily super.from, required int super.argument})
      : super(
          retry: null,
          name: r'researchWorkProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$researchWorkHash();

  @override
  String toString() {
    return r'researchWorkProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ResearchWork create() => ResearchWork();

  @override
  bool operator ==(Object other) {
    return other is ResearchWorkProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$researchWorkHash() => r'67be6cb802fafd125dada0ee5440e7532e878b4a';

final class ResearchWorkFamily extends $Family
    with
        $ClassFamilyOverride<ResearchWork, AsyncValue<Searched>, Searched,
            FutureOr<Searched>, int> {
  ResearchWorkFamily._()
      : super(
          retry: null,
          name: r'researchWorkProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  ResearchWorkProvider call(
    int documentID,
  ) =>
      ResearchWorkProvider._(argument: documentID, from: this);

  @override
  String toString() => r'researchWorkProvider';
}

abstract class _$ResearchWork extends $AsyncNotifier<Searched> {
  late final _$args = ref.$arg as int;
  int get documentID => _$args;

  FutureOr<Searched> build(
    int documentID,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Searched>, Searched>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<Searched>, Searched>,
        AsyncValue<Searched>,
        Object?,
        Object?>;
    element.handleCreate(
        ref,
        () => build(
              _$args,
            ));
  }
}

/// likes のバックグラウンド更新中かどうかを管理するProvider（スナックバー表示に使用）

@ProviderFor(IsRefreshingLikes)
final isRefreshingLikesProvider = IsRefreshingLikesFamily._();

/// likes のバックグラウンド更新中かどうかを管理するProvider（スナックバー表示に使用）
final class IsRefreshingLikesProvider
    extends $NotifierProvider<IsRefreshingLikes, bool> {
  /// likes のバックグラウンド更新中かどうかを管理するProvider（スナックバー表示に使用）
  IsRefreshingLikesProvider._(
      {required IsRefreshingLikesFamily super.from,
      required int super.argument})
      : super(
          retry: null,
          name: r'isRefreshingLikesProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$isRefreshingLikesHash();

  @override
  String toString() {
    return r'isRefreshingLikesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  IsRefreshingLikes create() => IsRefreshingLikes();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is IsRefreshingLikesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$isRefreshingLikesHash() => r'40a12be1a7035124b01fc174a12ae43c4313a683';

/// likes のバックグラウンド更新中かどうかを管理するProvider（スナックバー表示に使用）

final class IsRefreshingLikesFamily extends $Family
    with $ClassFamilyOverride<IsRefreshingLikes, bool, bool, bool, int> {
  IsRefreshingLikesFamily._()
      : super(
          retry: null,
          name: r'isRefreshingLikesProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// likes のバックグラウンド更新中かどうかを管理するProvider（スナックバー表示に使用）

  IsRefreshingLikesProvider call(
    int documentID,
  ) =>
      IsRefreshingLikesProvider._(argument: documentID, from: this);

  @override
  String toString() => r'isRefreshingLikesProvider';
}

/// likes のバックグラウンド更新中かどうかを管理するProvider（スナックバー表示に使用）

abstract class _$IsRefreshingLikes extends $Notifier<bool> {
  late final _$args = ref.$arg as int;
  int get documentID => _$args;

  bool build(
    int documentID,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<bool, bool>, bool, Object?, Object?>;
    element.handleCreate(
        ref,
        () => build(
              _$args,
            ));
  }
}
