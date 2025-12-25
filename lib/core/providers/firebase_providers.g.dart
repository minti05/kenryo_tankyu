// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firebase_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(firebaseAuth)
const firebaseAuthProvider = FirebaseAuthProvider._();

final class FirebaseAuthProvider
    extends $FunctionalProvider<FirebaseAuth, FirebaseAuth, FirebaseAuth>
    with $Provider<FirebaseAuth> {
  const FirebaseAuthProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'firebaseAuthProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$firebaseAuthHash();

  @$internal
  @override
  $ProviderElement<FirebaseAuth> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FirebaseAuth create(Ref ref) {
    return firebaseAuth(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FirebaseAuth value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FirebaseAuth>(value),
    );
  }
}

String _$firebaseAuthHash() => r'912368c3df3f72e4295bf7a8cda93b9c5749d923';

@ProviderFor(firebaseFirestore)
const firebaseFirestoreProvider = FirebaseFirestoreProvider._();

final class FirebaseFirestoreProvider extends $FunctionalProvider<
    FirebaseFirestore,
    FirebaseFirestore,
    FirebaseFirestore> with $Provider<FirebaseFirestore> {
  const FirebaseFirestoreProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'firebaseFirestoreProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$firebaseFirestoreHash();

  @$internal
  @override
  $ProviderElement<FirebaseFirestore> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FirebaseFirestore create(Ref ref) {
    return firebaseFirestore(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FirebaseFirestore value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FirebaseFirestore>(value),
    );
  }
}

String _$firebaseFirestoreHash() => r'963402713bf9b7cc1fb259d619d9b0184d4dcec1';

@ProviderFor(firebaseStorage)
const firebaseStorageProvider = FirebaseStorageProvider._();

final class FirebaseStorageProvider extends $FunctionalProvider<FirebaseStorage,
    FirebaseStorage, FirebaseStorage> with $Provider<FirebaseStorage> {
  const FirebaseStorageProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'firebaseStorageProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$firebaseStorageHash();

  @$internal
  @override
  $ProviderElement<FirebaseStorage> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FirebaseStorage create(Ref ref) {
    return firebaseStorage(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FirebaseStorage value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FirebaseStorage>(value),
    );
  }
}

String _$firebaseStorageHash() => r'aa6946fd2a3470c4f3e2e72956076591cc63b435';
