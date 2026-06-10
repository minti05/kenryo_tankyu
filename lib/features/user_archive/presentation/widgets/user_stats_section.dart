import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kenryo_tankyu/core/utils/device_type.dart';
import 'package:kenryo_tankyu/features/user_archive/domain/models/user_stats.dart';
import 'package:kenryo_tankyu/features/user_archive/presentation/providers/user_stats_provider.dart';

class UserStatsSection extends ConsumerWidget {
  const UserStatsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncStats = ref.watch(userStatsProvider);

    return asyncStats.when(
      loading: () => _StatsLayout(stats: null),
      error: (_, __) => const SizedBox.shrink(),
      data: (stats) => _StatsLayout(stats: stats),
      // リフレッシュ中は前回データを表示し続ける（チラつき防止）
      skipLoadingOnReload: true,
    );
  }
}

class _StatsLayout extends StatelessWidget {
  const _StatsLayout({required this.stats});

  final UserStats? stats;

  @override
  Widget build(BuildContext context) {
    if (context.isTablet) {
      return IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 2,
              child: _StreakCard(streakDays: stats?.streakDays),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _CountCard(
                label: '今日',
                count: stats?.todayViews,
                icon: Icons.today_outlined,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _CountCard(
                label: '7日間',
                count: stats?.weekViews,
                icon: Icons.date_range_outlined,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _CountCard(
                label: '累計',
                count: stats?.totalViews,
                icon: Icons.library_books_outlined,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _StreakCard(streakDays: stats?.streakDays),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _CountCard(
                label: '今日',
                count: stats?.todayViews,
                icon: Icons.today_outlined,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _CountCard(
                label: '7日間',
                count: stats?.weekViews,
                icon: Icons.date_range_outlined,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _CountCard(
                label: '累計',
                count: stats?.totalViews,
                icon: Icons.library_books_outlined,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _StreakCard extends StatelessWidget {
  const _StreakCard({required this.streakDays});

  final int? streakDays;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isLoading = streakDays == null;
    final days = streakDays ?? 0;

    return Card(
      color: colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Image.asset(
              'assets/images/app_icon.png',
              width: 28,
              height: 28,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isLoading ? '読み込み中...' : '$days日連続閲覧中！',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onPrimaryContainer,
                    ),
                  ),
                  Text(
                    '毎日続けて探究を深めよう',
                    style: TextStyle(
                      fontSize: 11,
                      color:
                          colorScheme.onPrimaryContainer.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
            if (!isLoading) _AnimatedDaysCounter(days: days),
          ],
        ),
      ),
    );
  }
}

class _AnimatedDaysCounter extends StatefulWidget {
  const _AnimatedDaysCounter({required this.days});
  final int days;

  @override
  State<_AnimatedDaysCounter> createState() => _AnimatedDaysCounterState();
}

class _AnimatedDaysCounterState extends State<_AnimatedDaysCounter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _animation = Tween<double>(begin: 0, end: widget.days.toDouble())
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void didUpdateWidget(_AnimatedDaysCounter old) {
    super.didUpdateWidget(old);
    if (old.days != widget.days) {
      // 前回の値から始めることで自然なカウントアップになる
      _animation = Tween<double>(
        begin: old.days.toDouble(),
        end: widget.days.toDouble(),
      ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${_animation.value.toInt()}',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 4),
              child: Text(
                '日',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _CountCard extends StatefulWidget {
  const _CountCard({
    required this.label,
    required this.count,
    required this.icon,
  });

  final String label;
  final int? count;
  final IconData icon;

  @override
  State<_CountCard> createState() => _CountCardState();
}

class _CountCardState extends State<_CountCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _animation = Tween<double>(begin: 0, end: (widget.count ?? 0).toDouble())
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    if (widget.count != null) _controller.forward();
  }

  @override
  void didUpdateWidget(_CountCard old) {
    super.didUpdateWidget(old);
    if (old.count != widget.count && widget.count != null) {
      // 前回の値から始めることで自然なカウントアップになる
      final begin = (old.count ?? 0).toDouble();
      _animation = Tween<double>(begin: begin, end: widget.count!.toDouble())
          .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isLoading = widget.count == null;

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Column(
          children: [
            Icon(widget.icon, size: 20, color: colorScheme.primary),
            const SizedBox(height: 4),
            isLoading
                ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : AnimatedBuilder(
                    animation: _animation,
                    builder: (context, _) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${_animation.value.toInt()}',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onSurface,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 2),
                            child: Text(
                              '件',
                              style: TextStyle(
                                fontSize: 11,
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
            const SizedBox(height: 2),
            Text(
              widget.label,
              style: TextStyle(
                fontSize: 11,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
