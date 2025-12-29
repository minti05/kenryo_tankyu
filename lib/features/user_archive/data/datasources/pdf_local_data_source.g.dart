// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pdf_local_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(pdfLocalDataSource)
const pdfLocalDataSourceProvider = PdfLocalDataSourceProvider._();

final class PdfLocalDataSourceProvider extends $FunctionalProvider<
    PdfLocalDataSource,
    PdfLocalDataSource,
    PdfLocalDataSource> with $Provider<PdfLocalDataSource> {
  const PdfLocalDataSourceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'pdfLocalDataSourceProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$pdfLocalDataSourceHash();

  @$internal
  @override
  $ProviderElement<PdfLocalDataSource> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PdfLocalDataSource create(Ref ref) {
    return pdfLocalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PdfLocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PdfLocalDataSource>(value),
    );
  }
}

String _$pdfLocalDataSourceHash() =>
    r'06e8c25fba256390778ff32fb58f38ef94973550';
