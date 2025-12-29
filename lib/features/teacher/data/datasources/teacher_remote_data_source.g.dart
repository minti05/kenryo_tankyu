// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_remote_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(teacherRemoteDataSource)
const teacherRemoteDataSourceProvider = TeacherRemoteDataSourceProvider._();

final class TeacherRemoteDataSourceProvider extends $FunctionalProvider<
    TeacherRemoteDataSource,
    TeacherRemoteDataSource,
    TeacherRemoteDataSource> with $Provider<TeacherRemoteDataSource> {
  const TeacherRemoteDataSourceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'teacherRemoteDataSourceProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$teacherRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<TeacherRemoteDataSource> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TeacherRemoteDataSource create(Ref ref) {
    return teacherRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TeacherRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TeacherRemoteDataSource>(value),
    );
  }
}

String _$teacherRemoteDataSourceHash() =>
    r'96d52d911e1555082c791aafee3e32ed96faa407';
