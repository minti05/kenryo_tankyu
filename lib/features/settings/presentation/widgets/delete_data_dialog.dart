import 'package:flutter/material.dart';
import 'package:kenryo_tankyu/features/user_archive/domain/models/archive_stats.dart';

class DeleteDataDialog extends StatefulWidget {
  final List<DateTime> historyDates;
  final List<PdfCacheEntry> pdfEntries;
  final Future<void> Function() onDeleteAllHistory;
  final Future<void> Function(DateTime before) onDeleteHistoryBefore;
  final Future<void> Function() onDeleteAllPdf;
  final Future<void> Function(DateTime before) onDeletePdfBefore;

  const DeleteDataDialog({
    super.key,
    required this.historyDates,
    required this.pdfEntries,
    required this.onDeleteAllHistory,
    required this.onDeleteHistoryBefore,
    required this.onDeleteAllPdf,
    required this.onDeletePdfBefore,
  });

  @override
  State<DeleteDataDialog> createState() => _DeleteDataDialogState();
}

class _DeleteDataDialogState extends State<DeleteDataDialog>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  double _nDays = 30;
  bool _isDeleting = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  DateTime get _cutoff =>
      DateTime.now().subtract(Duration(days: _nDays.round()));

  int get _affectedHistoryCount =>
      widget.historyDates.where((d) => d.isBefore(_cutoff)).length;

  int get _affectedPdfBytes => widget.pdfEntries
      .where((e) => e.date.isBefore(_cutoff))
      .fold(0, (sum, e) => sum + e.bytes);

  int get _totalPdfBytes =>
      widget.pdfEntries.fold(0, (sum, e) => sum + e.bytes);

  Future<void> _run(Future<void> Function() action, String successMsg) async {
    setState(() => _isDeleting = true);
    try {
      await action();
      if (mounted) Navigator.pop(context, successMsg);
    } catch (_) {
      if (mounted) {
        setState(() => _isDeleting = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('削除に失敗しました')),
        );
      }
    }
  }

  void _onDeleteBefore() {
    if (_tabController.index == 0) {
      _run(
        () => widget.onDeleteHistoryBefore(_cutoff),
        '${_nDays.round()}日以上前の閲覧履歴を削除しました',
      );
    } else {
      _run(
        () => widget.onDeletePdfBefore(_cutoff),
        '${_nDays.round()}日以上前のPDFキャッシュを削除しました',
      );
    }
  }

  void _onDeleteAll() {
    if (_tabController.index == 0) {
      _run(widget.onDeleteAllHistory, '全ての閲覧履歴を削除しました');
    } else {
      _run(widget.onDeleteAllPdf, '全てのPDFキャッシュを削除しました');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final nDaysRound = _nDays.round();
    final isHistoryTab = _tabController.index == 0;

    final canDeleteBefore =
        isHistoryTab ? _affectedHistoryCount > 0 : _affectedPdfBytes > 0;

    return AlertDialog(
      title: const Text('履歴の削除'),
      contentPadding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TabBar(
            controller: _tabController,
            tabs: const [Tab(text: '閲覧履歴'), Tab(text: 'PDFキャッシュ')],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 90,
            child: IndexedStack(
              index: _tabController.index,
              children: [
                _buildHistoryContent(theme),
                _buildPdfContent(theme),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // 共通スライダー
          Row(
            children: [
              Text('$nDaysRound日以上前', style: theme.textTheme.bodySmall),
              Expanded(
                child: Slider(
                  min: 1,
                  max: 100,
                  value: _nDays,
                  onChanged:
                      _isDeleting ? null : (v) => setState(() => _nDays = v),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('1日', style: theme.textTheme.labelSmall),
              Text('100日', style: theme.textTheme.labelSmall),
            ],
          ),
          const SizedBox(height: 4),
        ],
      ),
      actions: [
        TextButton(
          onPressed: _isDeleting ? null : () => Navigator.pop(context),
          child: const Text('キャンセル'),
        ),
        TextButton(
          onPressed: (_isDeleting || !canDeleteBefore) ? null : _onDeleteBefore,
          child: _isDeleting
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text('$nDaysRound日以上前を削除'),
        ),
        TextButton(
          onPressed: _isDeleting ? null : _onDeleteAll,
          style: TextButton.styleFrom(
            foregroundColor: theme.colorScheme.error,
          ),
          child: const Text('全て削除'),
        ),
      ],
    );
  }

  Widget _buildHistoryContent(ThemeData theme) {
    final total = widget.historyDates.length;
    final affected = _affectedHistoryCount;

    if (total == 0) {
      return Center(
        child: Text('閲覧履歴はありません', style: theme.textTheme.bodyMedium),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('全$total件の閲覧履歴があります'),
        const SizedBox(height: 12),
        Row(
          children: [
            Text(
              '$affected / $total 件が対象',
              style: theme.textTheme.titleMedium?.copyWith(
                color: affected > 0 ? theme.colorScheme.primary : null,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPdfContent(ThemeData theme) {
    final total = widget.pdfEntries.length;
    final totalBytes = _totalPdfBytes;
    final affectedBytes = _affectedPdfBytes;
    final ratio = totalBytes > 0 ? affectedBytes / totalBytes : 0.0;

    if (total == 0) {
      return Center(
        child: Text('PDFキャッシュはありません', style: theme.textTheme.bodyMedium),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('全$total件 (${_formatBytes(totalBytes)}) のキャッシュがあります'),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: ratio,
            minHeight: 10,
            backgroundColor: theme.colorScheme.surfaceContainerHighest,
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '${_formatBytes(affectedBytes)} / ${_formatBytes(totalBytes)} が解放されます',
          style: theme.textTheme.bodySmall,
        ),
      ],
    );
  }

  String _formatBytes(int bytes) {
    if (bytes < 1024) return '${bytes}B';
    if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)}KB';
    }
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)}MB';
  }
}
