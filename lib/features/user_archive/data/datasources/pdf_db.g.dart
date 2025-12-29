// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pdf_db.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(pdfDbDataSource)
const pdfDbDataSourceProvider = PdfDbDataSourceProvider._();

final class PdfDbDataSourceProvider extends $FunctionalProvider<PdfDbDataSource,
    PdfDbDataSource, PdfDbDataSource> with $Provider<PdfDbDataSource> {
  const PdfDbDataSourceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'pdfDbDataSourceProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$pdfDbDataSourceHash();

  @$internal
  @override
  $ProviderElement<PdfDbDataSource> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PdfDbDataSource create(Ref ref) {
    return pdfDbDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PdfDbDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PdfDbDataSource>(value),
    );
  }
}

String _$pdfDbDataSourceHash() => r'6a9cc7c94232354c25cf11ee327c7baa1169fc5b';
