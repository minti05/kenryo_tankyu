typedef HistoryStats = ({int count, DateTime? oldest, DateTime? newest});
typedef PdfCacheStats = ({
  int count,
  int totalBytes,
  DateTime? oldest,
  DateTime? newest
});
typedef PdfCacheEntry = ({DateTime date, int bytes});
