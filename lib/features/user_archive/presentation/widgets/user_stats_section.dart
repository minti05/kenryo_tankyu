import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    );
  }
}

class _StatsLayout extends StatelessWidget {
  const _StatsLayout({required this.stats});

  final UserStats? stats;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _StreakCard(streakDays: stats?.streakDays),
        SizedBox(height: 8.h),
        Row(
          children: [
            Expanded(
              child: _CountCard(
                label: '今日',
                count: stats?.todayViews,
                icon: Icons.today_outlined,
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: _CountCard(
                label: '7日間',
                count: stats?.weekViews,
                icon: Icons.date_range_outlined,
              ),
            ),
            SizedBox(width: 8.w),
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
    final days = streakDays ?? 0;

    return Card(
      color: colorScheme.primaryContainer,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Row(
          children: [
            Text('🔥', style: TextStyle(fontSize: 22.sp)),
            SizedBox(width: 8.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$days日連続閲覧中！',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onPrimaryContainer,
                    ),
                  ),
                  Text(
                    '毎日続けて探究を深めよう',
                    style: TextStyle(
                      fontSize: 11.sp,
                      color:
                          colorScheme.onPrimaryContainer.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
            _AnimatedDaysCounter(days: days),
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
      _animation = Tween<double>(begin: 0, end: widget.days.toDouble())
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
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        return Text(
          '${_animation.value.toInt()}',
          style: TextStyle(
            fontSize: 32.sp,
            fontWeight: FontWeight.bold,
            color: colorScheme.primary,
          ),
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
      _animation = Tween<double>(begin: 0, end: widget.count!.toDouble())
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
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
        child: Column(
          children: [
            Icon(widget.icon, size: 20.sp, color: colorScheme.primary),
            SizedBox(height: 4.h),
            isLoading
                ? SizedBox(
                    height: 24.h,
                    width: 24.w,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : AnimatedBuilder(
                    animation: _animation,
                    builder: (context, _) {
                      return Text(
                        '${_animation.value.toInt()}',
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                      );
                    },
                  ),
            SizedBox(height: 2.h),
            Text(
              widget.label,
              style: TextStyle(
                fontSize: 11.sp,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            Text(
              '件閲覧',
              style: TextStyle(
                fontSize: 10.sp,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
