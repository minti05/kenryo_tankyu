import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kenryo_tankyu/core/constants/work/award_value.dart';
import 'package:kenryo_tankyu/core/constants/work/info_value.dart';
import 'package:kenryo_tankyu/features/krgp/presentation/providers/krgp_provider.dart';
import 'package:kenryo_tankyu/features/research_work/domain/models/searched.dart';
import 'package:kenryo_tankyu/features/search/presentation/widgets/result_preview_content.dart';
import 'package:kenryo_tankyu/presentation/widget/error_view.dart';

class KrgpAwardsPage extends ConsumerStatefulWidget {
  const KrgpAwardsPage({super.key});

  @override
  ConsumerState<KrgpAwardsPage> createState() => _KrgpAwardsPageState();
}

class _KrgpAwardsPageState extends ConsumerState<KrgpAwardsPage>
    with TickerProviderStateMixin {
  KrgpSortMode _sortMode = KrgpSortMode.year;
  TabController? _tabController;

  static const _years = [
    EnterYear.enter2024,
    EnterYear.enter2023,
    EnterYear.enter2022,
    EnterYear.enter2021,
    EnterYear.enter2020,
  ];

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  void _buildTabController(int length) {
    _tabController?.dispose();
    _tabController = TabController(length: length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final asyncWorks = ref.watch(krgpAwardsProvider);

    return asyncWorks.when(
      loading: () => Scaffold(
        appBar: _buildAppBar(context, null),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (e, st) => Scaffold(
        appBar: _buildAppBar(context, null),
        body: CommonErrorView(
          error: e,
          onRetry: () => ref.invalidate(krgpAwardsProvider),
        ),
      ),
      data: (works) {
        if (_sortMode == KrgpSortMode.year) {
          final grouped = groupByYear(works);
          final availableYears =
              _years.where((y) => grouped.containsKey(y)).toList();
          if (_tabController == null ||
              _tabController!.length != availableYears.length) {
            _buildTabController(availableYears.length);
          }
          return Scaffold(
            appBar: _buildAppBar(context, _tabController),
            body: availableYears.isEmpty
                ? const Center(child: Text('データがありません'))
                : Column(
                    children: [
                      TabBar(
                        controller: _tabController,
                        isScrollable: true,
                        tabAlignment: TabAlignment.start,
                        tabs: availableYears
                            .map((y) => Tab(text: '${y.displayName}年度入学'))
                            .toList(),
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: availableYears
                              .map((y) => _YearTabContent(
                                    yearData: grouped[y]!,
                                  ))
                              .toList(),
                        ),
                      ),
                    ],
                  ),
          );
        } else {
          final grouped = groupByAward(works);
          final availableTypes =
              AwardType.values.where((t) => grouped.containsKey(t)).toList();
          if (_tabController == null ||
              _tabController!.length != availableTypes.length) {
            _buildTabController(availableTypes.length);
          }
          return Scaffold(
            appBar: _buildAppBar(context, _tabController),
            body: availableTypes.isEmpty
                ? const Center(child: Text('データがありません'))
                : Column(
                    children: [
                      TabBar(
                        controller: _tabController,
                        isScrollable: true,
                        tabAlignment: TabAlignment.start,
                        tabs: availableTypes
                            .map((t) => Tab(text: t.displayName))
                            .toList(),
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: availableTypes
                              .map((t) => _AwardTabContent(
                                    awardData: grouped[t]!,
                                  ))
                              .toList(),
                        ),
                      ),
                    ],
                  ),
          );
        }
      },
    );
  }

  AppBar _buildAppBar(BuildContext context, TabController? tabController) {
    return AppBar(
      title: const Text('KRGP受賞作品'),
      actions: [
        PopupMenuButton<KrgpSortMode>(
          icon: const Icon(Icons.sort),
          tooltip: '並び替え',
          initialValue: _sortMode,
          onSelected: (mode) {
            if (mode == _sortMode) return;
            setState(() {
              _sortMode = mode;
              _tabController = null;
            });
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: KrgpSortMode.year,
              child: Text('年度ごと'),
            ),
            const PopupMenuItem(
              value: KrgpSortMode.award,
              child: Text('賞ごと'),
            ),
          ],
        ),
      ],
    );
  }
}

class _YearTabContent extends StatelessWidget {
  final Map<AwardType, Map<String?, List<Searched>>> yearData;
  const _YearTabContent({required this.yearData});

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[];

    for (final type in AwardType.values) {
      final byName = yearData[type];
      if (byName == null) continue;

      items.add(_SectionHeader(label: type.displayName, isTop: items.isEmpty));

      for (final entry in byName.entries) {
        if (entry.key != null) {
          items.add(_SubSectionHeader(label: entry.key!));
        }
        for (final work in entry.value) {
          items.add(_WorkCard(work: work));
        }
      }
    }

    return ListView(children: items);
  }
}

class _AwardTabContent extends StatelessWidget {
  final Map<String?, Map<EnterYear, List<Searched>>> awardData;
  const _AwardTabContent({required this.awardData});

  @override
  Widget build(BuildContext context) {
    const yearsDesc = [
      EnterYear.enter2024,
      EnterYear.enter2023,
      EnterYear.enter2022,
      EnterYear.enter2021,
      EnterYear.enter2020,
    ];

    final items = <Widget>[];
    var isFirst = true;

    for (final entry in awardData.entries) {
      if (entry.key != null) {
        items.add(_SectionHeader(label: entry.key!, isTop: isFirst));
        isFirst = false;
      }
      for (final year in yearsDesc) {
        final works = entry.value[year];
        if (works == null) continue;

        if (entry.key != null) {
          items.add(_SubSectionHeader(label: '${year.displayName}年度入学'));
        } else {
          items.add(
              _SectionHeader(label: '${year.displayName}年度入学', isTop: isFirst));
          isFirst = false;
        }
        for (final work in works) {
          items.add(_WorkCard(work: work));
        }
      }
    }

    return ListView(children: items);
  }
}

class _SectionHeader extends StatelessWidget {
  final String label;
  final bool isTop;
  const _SectionHeader({required this.label, required this.isTop});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding:
          EdgeInsets.only(left: 16, right: 16, top: isTop ? 12 : 20, bottom: 8),
      child: Text(
        label,
        style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _SubSectionHeader extends StatelessWidget {
  final String label;
  const _SubSectionHeader({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 24, right: 16, top: 12, bottom: 4),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}

class _WorkCard extends StatelessWidget {
  final Searched work;
  const _WorkCard({required this.work});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: ResultPreviewContent(
        searched: work,
        mode: ResultPreviewMode.search,
        showAwardChip: false,
      ),
    );
  }
}
