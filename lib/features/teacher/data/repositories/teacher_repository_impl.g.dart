// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_repository_impl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(teacherRepository)
const teacherRepositoryProvider = TeacherRepositoryProvider._();

final class TeacherRepositoryProvider extends $FunctionalProvider<
    TeacherRepository,
    TeacherRepository,
    TeacherRepository> with $Provider<TeacherRepository> {
  const TeacherRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'teacherRepositoryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$teacherRepositoryHash();

  @$internal
  @override
  $ProviderElement<TeacherRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TeacherRepository create(Ref ref) {
    return teacherRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TeacherRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TeacherRepository>(value),
    );
  }
}

String _$teacherRepositoryHash() => r'8b8808eebf53865a0b6d5a8aa9a7363861a22d6f';
