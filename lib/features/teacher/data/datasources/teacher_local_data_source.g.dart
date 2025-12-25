// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_local_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(teacherLocalDataSource)
const teacherLocalDataSourceProvider = TeacherLocalDataSourceProvider._();

final class TeacherLocalDataSourceProvider extends $FunctionalProvider<
    TeacherLocalDataSource,
    TeacherLocalDataSource,
    TeacherLocalDataSource> with $Provider<TeacherLocalDataSource> {
  const TeacherLocalDataSourceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'teacherLocalDataSourceProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$teacherLocalDataSourceHash();

  @$internal
  @override
  $ProviderElement<TeacherLocalDataSource> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TeacherLocalDataSource create(Ref ref) {
    return teacherLocalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TeacherLocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TeacherLocalDataSource>(value),
    );
  }
}

String _$teacherLocalDataSourceHash() =>
    r'7c1edb3eec06907586a3c4299a59b991b0f99bdc';
