// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_stats_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserStatsNotifier)
final userStatsProvider = UserStatsNotifierProvider._();

final class UserStatsNotifierProvider
    extends $AsyncNotifierProvider<UserStatsNotifier, UserStats> {
  UserStatsNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'userStatsProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$userStatsNotifierHash();

  @$internal
  @override
  UserStatsNotifier create() => UserStatsNotifier();
}

String _$userStatsNotifierHash() => r'f5025c96523979c5c729073b3dc018337f5c8b5e';

abstract class _$UserStatsNotifier extends $AsyncNotifier<UserStats> {
  FutureOr<UserStats> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<UserStats>, UserStats>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<UserStats>, UserStats>,
        AsyncValue<UserStats>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}
