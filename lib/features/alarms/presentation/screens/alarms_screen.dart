import 'package:axle_tracking_cms/core/theme/design_system.dart';
import 'package:axle_tracking_cms/core/utils/date_time_utils.dart';
import 'package:axle_tracking_cms/core/widgets/axle_widgets.dart';
import 'package:axle_tracking_cms/features/alarms/presentation/providers/alarms_providers.dart';
import 'package:axle_tracking_cms/features/auth/presentation/providers/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AlarmsScreen extends ConsumerWidget {
  const AlarmsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);
    final isAdmin = authState.user?.email == null ||
        authState.user?.email == 'admin@axle.com';

    if (!isAdmin) {
      return const AxleBackground(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.lock_outline_rounded,
                  color: AxleColors.textMuted, size: 36),
              SizedBox(height: 12),
              Text(
                'Admin access required',
                style: TextStyle(
                  color: AxleColors.textSecondary,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Only admin users can view alarms.',
                style: TextStyle(color: AxleColors.textMuted, fontSize: 13),
              ),
            ],
          ),
        ),
      );
    }

    final state = ref.watch(alarmsControllerProvider);
    final controller = ref.read(alarmsControllerProvider.notifier);

    final criticalCount = state.alarms
        .where((a) =>
            (a.severity ?? '').toLowerCase().contains('crit'))
        .length;
    final warningCount = state.alarms
        .where((a) =>
            (a.severity ?? '').toLowerCase().contains('warn'))
        .length;
    final infoCount = state.alarms.length - criticalCount - warningCount;

    return AxleBackground(
      child: CustomScrollView(
        slivers: [
          // ── Date filter toolbar ──────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AxleSpacing.xxl,
                AxleSpacing.xxl,
                AxleSpacing.xxl,
                0,
              ),
              child: AxleGlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header row
                    Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: AxleColors.criticalDim,
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: const Icon(
                            Icons.tune_rounded,
                            size: 16,
                            color: AxleColors.critical,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Filter Alarms',
                          style: TextStyle(
                            color: AxleColors.textPrimary,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                        const Spacer(),
                        if (state.loading)
                          const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation(
                                  AxleColors.accent),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Date range display + pickers
                    Row(
                      children: [
                        Expanded(
                          child: _DateRangeField(
                            label: 'FROM',
                            value: state.from != null
                                ? DateTimeUtils.formatDateTime(state.from)
                                : 'Select date',
                            onTap: () async {
                              final now = DateTime.now();
                              final picked = await showDatePicker(
                                context: context,
                                firstDate:
                                    now.subtract(const Duration(days: 30)),
                                lastDate: now,
                                initialDate: state.from ?? now,
                              );
                              if (picked != null) {
                                controller.setRange(
                                  from: DateTime(
                                      picked.year, picked.month, picked.day),
                                  to: state.to ?? now,
                                );
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Icon(
                            Icons.arrow_forward_rounded,
                            size: 16,
                            color: AxleColors.textMuted,
                          ),
                        ),
                        Expanded(
                          child: _DateRangeField(
                            label: 'TO',
                            value: state.to != null
                                ? DateTimeUtils.formatDateTime(state.to)
                                : 'Select date',
                            onTap: () async {
                              final now = DateTime.now();
                              final picked = await showDatePicker(
                                context: context,
                                firstDate:
                                    now.subtract(const Duration(days: 30)),
                                lastDate: now,
                                initialDate: state.to ?? now,
                              );
                              if (picked != null) {
                                controller.setRange(
                                  from: state.from ??
                                      now.subtract(
                                          const Duration(hours: 24)),
                                  to: DateTime(picked.year, picked.month,
                                      picked.day, 23, 59, 59),
                                );
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        SizedBox(
                          height: 40,
                          child: ElevatedButton.icon(
                            onPressed: state.loading
                                ? null
                                : () async {
                                    final from = state.from;
                                    final to = state.to;
                                    if (from == null ||
                                        to == null ||
                                        from.isAfter(to)) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text('Invalid date range.'),
                                        ),
                                      );
                                      return;
                                    }
                                    await controller.load();
                                  },
                            icon: const Icon(Icons.search_rounded, size: 15),
                            label: const Text('Search'),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ── Summary pills ────────────────────────────────────────────
          if (state.alarms.isNotEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AxleSpacing.xxl,
                  AxleSpacing.lg,
                  AxleSpacing.xxl,
                  0,
                ),
                child: Row(
                  children: [
                    _SummaryPill(
                      label: 'Total',
                      count: state.alarms.length,
                      color: AxleColors.textSecondary,
                    ),
                    const SizedBox(width: 8),
                    _SummaryPill(
                      label: 'Critical',
                      count: criticalCount,
                      color: AxleColors.critical,
                    ),
                    const SizedBox(width: 8),
                    _SummaryPill(
                      label: 'Warning',
                      count: warningCount,
                      color: AxleColors.warning,
                    ),
                    const SizedBox(width: 8),
                    _SummaryPill(
                      label: 'Info',
                      count: infoCount,
                      color: AxleColors.info,
                    ),
                  ],
                ),
              ),
            ),

          // ── Alarm list / states ──────────────────────────────────────
          if (state.loading && state.alarms.isEmpty)
            SliverPadding(
              padding: const EdgeInsets.all(AxleSpacing.xxl),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (_, __) => const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: _AlarmSkeleton(),
                  ),
                  childCount: 5,
                ),
              ),
            )
          else if (state.errorMessage != null && state.alarms.isEmpty)
            SliverFillRemaining(
              child: Center(
                child: Text(
                  state.errorMessage!,
                  style: const TextStyle(color: AxleColors.critical),
                ),
              ),
            )
          else if (!state.loading && state.alarms.isEmpty)
            const SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.notifications_off_outlined,
                        color: AxleColors.textMuted, size: 36),
                    SizedBox(height: 12),
                    Text(
                      'No alarms in selected range',
                      style: TextStyle(color: AxleColors.textMuted),
                    ),
                  ],
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.all(AxleSpacing.xxl),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final alarm = state.alarms[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _AlarmCard(alarm: alarm),
                    );
                  },
                  childCount: state.alarms.length,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ── Date Range Field ──────────────────────────────────────────────────────────

class _DateRangeField extends StatelessWidget {
  const _DateRangeField({
    required this.label,
    required this.value,
    required this.onTap,
  });

  final String label;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AxleRadius.lg),
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: AxleColors.bgElevated,
          borderRadius: BorderRadius.circular(AxleRadius.lg),
          border: Border.all(color: AxleColors.border),
        ),
        child: Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                color: AxleColors.textMuted,
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                value,
                style: const TextStyle(
                  color: AxleColors.textPrimary,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Icon(
              Icons.calendar_today_rounded,
              size: 13,
              color: AxleColors.textMuted,
            ),
          ],
        ),
      ),
    );
  }
}

// ── Summary Pill ──────────────────────────────────────────────────────────────

class _SummaryPill extends StatelessWidget {
  const _SummaryPill({
    required this.label,
    required this.count,
    required this.color,
  });

  final String label;
  final int count;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            '$label: $count',
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Alarm Card ────────────────────────────────────────────────────────────────

class _AlarmCard extends StatelessWidget {
  const _AlarmCard({required this.alarm});

  final dynamic alarm;

  @override
  Widget build(BuildContext context) {
    final severity = alarm.severity ?? 'info';
    final severityColor = SeverityPill.colorFor(severity.toLowerCase());

    return Container(
      decoration: BoxDecoration(
        gradient: AxleColors.cardGradient,
        borderRadius: BorderRadius.circular(AxleRadius.xl),
        border: Border.all(color: AxleColors.borderCard),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left severity bar
          Container(
            width: 3,
            constraints: const BoxConstraints(minHeight: 80),
            decoration: BoxDecoration(
              color: severityColor.withValues(alpha: 0.85),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AxleRadius.xl),
                bottomLeft: Radius.circular(AxleRadius.xl),
              ),
            ),
          ),

          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AxleSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: severityColor.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          _iconForSeverity(severity),
                          size: 15,
                          color: severityColor,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${alarm.type}',
                              style: const TextStyle(
                                color: AxleColors.textPrimary,
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                              ),
                            ),
                            Text(
                              'Vehicle: ${alarm.vehicleId}',
                              style: const TextStyle(
                                color: AxleColors.textMuted,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SeverityPill(value: severity),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Message
                  Text(
                    '${alarm.message}',
                    style: const TextStyle(
                      color: AxleColors.textSecondary,
                      fontSize: 12,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Footer chips
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: [
                      _AlarmChip(
                        icon: Icons.access_time_rounded,
                        label: DateTimeUtils.formatDateTime(
                            alarm.occurredAt),
                      ),
                      _AlarmChip(
                        icon: Icons.location_on_rounded,
                        label:
                            '${alarm.latitude.toStringAsFixed(5)}, ${alarm.longitude.toStringAsFixed(5)}',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _iconForSeverity(String severity) {
    final v = severity.toLowerCase();
    if (v.contains('crit')) return Icons.error_rounded;
    if (v.contains('warn')) return Icons.warning_amber_rounded;
    return Icons.info_outline_rounded;
  }
}

class _AlarmChip extends StatelessWidget {
  const _AlarmChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AxleColors.bgElevated,
        borderRadius: BorderRadius.circular(AxleRadius.sm),
        border: Border.all(color: AxleColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 11, color: AxleColors.textMuted),
          const SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(
              color: AxleColors.textSecondary,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Alarm skeleton ────────────────────────────────────────────────────────────

class _AlarmSkeleton extends StatelessWidget {
  const _AlarmSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: axleGlassCard(),
      child: Row(
        children: [
          Container(
            width: 3,
            decoration: const BoxDecoration(
              color: AxleColors.bgHover,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AxleRadius.xl),
                bottomLeft: Radius.circular(AxleRadius.xl),
              ),
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AxleSkeleton(width: 180, height: 14),
                SizedBox(height: 8),
                AxleSkeleton(width: 280, height: 12),
                SizedBox(height: 8),
                AxleSkeleton(width: 200, height: 11),
              ],
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }
}
