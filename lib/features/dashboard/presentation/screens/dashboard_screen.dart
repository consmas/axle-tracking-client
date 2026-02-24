import 'package:axle_tracking_cms/core/theme/design_system.dart';
import 'package:axle_tracking_cms/core/widgets/axle_widgets.dart';
import 'package:axle_tracking_cms/features/vehicles/presentation/providers/vehicles_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehiclesState = ref.watch(vehiclesControllerProvider);
    final total = vehiclesState.vehicles.length;
    final online = vehiclesState.vehicles.where((v) => v.online).length;
    final offline = total - online;
    final onlineRatio = total == 0 ? 0.0 : online / total;

    return AxleBackground(
      child: RefreshIndicator(
        onRefresh: () =>
            ref.read(vehiclesControllerProvider.notifier).refresh(),
        color: AxleColors.accent,
        backgroundColor: AxleColors.bgCard,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(AxleSpacing.xxl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Metric Cards ───────────────────────────────────────────
              LayoutBuilder(
                builder: (context, constraints) {
                  final w = constraints.maxWidth;
                  if (w >= 840) {
                    return Row(
                      children: [
                        Expanded(
                          child: AxleMetricCard(
                            label: 'Total Fleet',
                            value: total.toString(),
                            icon: Icons.local_shipping_rounded,
                            accentColor: AxleColors.info,
                            subtitle: 'Registered vehicles',
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: AxleMetricCard(
                            label: 'Online',
                            value: online.toString(),
                            icon: Icons.signal_cellular_alt_rounded,
                            accentColor: AxleColors.accent,
                            subtitle: 'Active & transmitting',
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: AxleMetricCard(
                            label: 'Offline',
                            value: offline.toString(),
                            icon: Icons.signal_cellular_off_rounded,
                            accentColor: AxleColors.textSecondary,
                            subtitle: 'No signal or parked',
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: AxleMetricCard(
                            label: 'Active Alarms',
                            value: '—',
                            icon: Icons.notifications_active_rounded,
                            accentColor: AxleColors.critical,
                            subtitle: 'View alarm feed',
                            onTap: () => context.go('/alarms'),
                          ),
                        ),
                      ],
                    );
                  }
                  // 2-column grid fallback
                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: AxleMetricCard(
                              label: 'Total Fleet',
                              value: total.toString(),
                              icon: Icons.local_shipping_rounded,
                              accentColor: AxleColors.info,
                              subtitle: 'Registered vehicles',
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: AxleMetricCard(
                              label: 'Online',
                              value: online.toString(),
                              icon: Icons.signal_cellular_alt_rounded,
                              accentColor: AxleColors.accent,
                              subtitle: 'Active & transmitting',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          Expanded(
                            child: AxleMetricCard(
                              label: 'Offline',
                              value: offline.toString(),
                              icon: Icons.signal_cellular_off_rounded,
                              accentColor: AxleColors.textSecondary,
                              subtitle: 'No signal or parked',
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: AxleMetricCard(
                              label: 'Active Alarms',
                              value: '—',
                              icon: Icons.notifications_active_rounded,
                              accentColor: AxleColors.critical,
                              subtitle: 'View alarm feed',
                              onTap: () => context.go('/alarms'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 24),

              // ── Fleet Health + Quick Actions ───────────────────────────
              LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth >= 720;
                  if (isWide) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 280,
                          child: _FleetHealthCard(
                            total: total,
                            online: online,
                            offline: offline,
                            onlineRatio: onlineRatio,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(child: _QuickActionsCard()),
                      ],
                    );
                  }
                  return Column(
                    children: [
                      _FleetHealthCard(
                        total: total,
                        online: online,
                        offline: offline,
                        onlineRatio: onlineRatio,
                      ),
                      const SizedBox(height: 14),
                      _QuickActionsCard(),
                    ],
                  );
                },
              ),

              if (vehiclesState.errorMessage != null) ...[
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.all(AxleSpacing.md),
                  decoration: BoxDecoration(
                    color: AxleColors.criticalDim,
                    borderRadius: BorderRadius.circular(AxleRadius.lg),
                    border: Border.all(
                      color: AxleColors.critical.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline_rounded,
                          color: AxleColors.critical, size: 16),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          vehiclesState.errorMessage!,
                          style: const TextStyle(
                            color: AxleColors.critical,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// ── Fleet Health Card ─────────────────────────────────────────────────────────

class _FleetHealthCard extends StatelessWidget {
  const _FleetHealthCard({
    required this.total,
    required this.online,
    required this.offline,
    required this.onlineRatio,
  });

  final int total;
  final int online;
  final int offline;
  final double onlineRatio;

  @override
  Widget build(BuildContext context) {
    return AxleGlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AxleColors.accentDim,
                  borderRadius: BorderRadius.circular(9),
                ),
                child: const Icon(
                  Icons.bar_chart_rounded,
                  size: 16,
                  color: AxleColors.accent,
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'Fleet Health',
                style: TextStyle(
                  color: AxleColors.textPrimary,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Online ratio bar
          Row(
            children: [
              const Text(
                'Online Rate',
                style: TextStyle(
                  color: AxleColors.textSecondary,
                  fontSize: 12,
                ),
              ),
              const Spacer(),
              Text(
                '${(onlineRatio * 100).toStringAsFixed(0)}%',
                style: const TextStyle(
                  color: AxleColors.accent,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Stack(
              children: [
                Container(
                  height: 6,
                  color: AxleColors.bgElevated,
                ),
                FractionallySizedBox(
                  widthFactor: onlineRatio.clamp(0, 1),
                  child: Container(
                    height: 6,
                    decoration: BoxDecoration(
                      gradient: AxleColors.accentGradient,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Stats row
          Row(
            children: [
              _StatItem(
                value: total.toString(),
                label: 'Total',
                color: AxleColors.textSecondary,
              ),
              const SizedBox(width: 16),
              _StatItem(
                value: online.toString(),
                label: 'Online',
                color: AxleColors.accent,
              ),
              const SizedBox(width: 16),
              _StatItem(
                value: offline.toString(),
                label: 'Offline',
                color: AxleColors.textMuted,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.value,
    required this.label,
    required this.color,
  });

  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 20,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: AxleColors.textMuted,
            fontSize: 10,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.4,
          ),
        ),
      ],
    );
  }
}

// ── Quick Actions Card ────────────────────────────────────────────────────────

class _QuickActionsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AxleGlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AxleColors.infoDim,
                  borderRadius: BorderRadius.circular(9),
                ),
                child: const Icon(
                  Icons.apps_rounded,
                  size: 16,
                  color: AxleColors.info,
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'Quick Actions',
                style: TextStyle(
                  color: AxleColors.textPrimary,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              AxleQuickAction(
                label: 'Fleet',
                icon: Icons.local_shipping_rounded,
                color: AxleColors.info,
                onTap: () => context.go('/vehicles'),
              ),
              AxleQuickAction(
                label: 'Live Map',
                icon: Icons.map_rounded,
                color: AxleColors.accent,
                onTap: () => context.go('/tracking'),
              ),
              AxleQuickAction(
                label: 'Playback',
                icon: Icons.play_circle_fill_rounded,
                color: AxleColors.warning,
                onTap: () => context.go('/playback'),
              ),
              AxleQuickAction(
                label: 'Alarms',
                icon: Icons.notifications_active_rounded,
                color: AxleColors.critical,
                onTap: () => context.go('/alarms'),
              ),
              AxleQuickAction(
                label: 'Live Video',
                icon: Icons.videocam_rounded,
                color: AxleColors.info,
                onTap: () => context.go('/video'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
