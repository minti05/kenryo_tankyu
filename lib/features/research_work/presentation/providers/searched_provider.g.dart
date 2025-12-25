// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'searched_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(researchWork)
const researchWorkProvider = ResearchWorkFamily._();

final class ResearchWorkProvider extends $FunctionalProvider<
        AsyncValue<Searched>, Searched, FutureOr<Searched>>
    with $FutureModifier<Searched>, $FutureProvider<Searched> {
  const ResearchWorkProvider._(
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
  $FutureProviderElement<Searched> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Searched> create(Ref ref) {
    final argument = this.argument as int;
    return researchWork(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ResearchWorkProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$researchWorkHash() => r'c79ee15529bdc74d9f43555a3544f2fe93ba4d33';

final class ResearchWorkFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Searched>, int> {
  const ResearchWorkFamily._()
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
