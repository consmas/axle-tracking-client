import 'package:axle_tracking_cms/core/theme/design_system.dart';
import 'package:axle_tracking_cms/core/utils/date_time_utils.dart';
import 'package:axle_tracking_cms/core/widgets/axle_widgets.dart';
import 'package:axle_tracking_cms/features/tracking/domain/entities/map_feed_vehicle.dart';
import 'package:axle_tracking_cms/features/tracking/presentation/providers/tracking_providers.dart';
import 'package:axle_tracking_cms/features/vehicles/presentation/providers/vehicles_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class VehiclesScreen extends ConsumerStatefulWidget {
  const VehiclesScreen({super.key});

  @override
  ConsumerState<VehiclesScreen> createState() => _VehiclesScreenState();
}

class _VehiclesScreenState extends ConsumerState<VehiclesScreen> {
  String _filter = 'all';
  String _search = '';

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(vehiclesControllerProvider);
    final controller = ref.read(vehiclesControllerProvider.notifier);

    // Derive per-vehicle status (speed, location, time) from the single
    // /map_feed response instead of firing N individual /status requests.
    final feedAsync = ref.watch(mapFeedProvider);
    final feedStatusMap = {
      for (final v in feedAsync.valueOrNull ?? <MapFeedVehicle>[]) v.id: v.status
    };

    final vehicles = state.vehicles.where((v) {
      if (_filter == 'online' && !v.online) return false;
      if (_filter == 'offline' && v.online) return false;
      final q = _search.toLowerCase();
      if (q.isNotEmpty) {
        final name = v.name?.toLowerCase() ?? '';
        final plate = v.plateNumber?.toLowerCase() ?? '';
        final id = v.id.toLowerCase();
        if (!name.contains(q) && !plate.contains(q) && !id.contains(q)) {
          return false;
        }
      }
      return true;
    }).toList(growable: false);

    final totalCount = state.vehicles.length;
    final onlineCount = state.vehicles.where((v) => v.online).length;
    final offlineCount = totalCount - onlineCount;

    return AxleBackground(
      child: RefreshIndicator(
        onRefresh: controller.refresh,
        color: AxleColors.accent,
        backgroundColor: AxleColors.bgCard,
        child: CustomScrollView(
          slivers: [
            // ── Search + Filter bar ───────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AxleSpacing.xxl,
                  AxleSpacing.xxl,
                  AxleSpacing.xxl,
                  0,
                ),
                child: AxleGlassCard(
                  padding: const EdgeInsets.all(AxleSpacing.lg),
                  child: Column(
                    children: [
                      // Search row
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 40,
                              child: TextField(
                                onChanged: (v) =>
                                    setState(() => _search = v),
                                style: const TextStyle(
                                  color: AxleColors.textPrimary,
                                  fontSize: 13,
                                ),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 0,
                                  ),
                                  prefixIcon: const Icon(
                                    Icons.search_rounded,
                                    size: 16,
                                    color: AxleColors.textMuted,
                                  ),
                                  hintText:
                                      'Search by name, plate or ID…',
                                  hintStyle: const TextStyle(
                                    color: AxleColors.textMuted,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Filter chips + counts
                      Row(
                        children: [
                          _FilterChip(
                            label: 'All',
                            count: totalCount,
                            selected: _filter == 'all',
                            onTap: () => setState(() => _filter = 'all'),
                          ),
                          const SizedBox(width: 8),
                          _FilterChip(
                            label: 'Online',
                            count: onlineCount,
                            selected: _filter == 'online',
                            activeColor: AxleColors.accent,
                            onTap: () =>
                                setState(() => _filter = 'online'),
                          ),
                          const SizedBox(width: 8),
                          _FilterChip(
                            label: 'Offline',
                            count: offlineCount,
                            selected: _filter == 'offline',
                            activeColor: AxleColors.textMuted,
                            onTap: () =>
                                setState(() => _filter = 'offline'),
                          ),
                          const Spacer(),
                          Text(
                            '${vehicles.length} result${vehicles.length == 1 ? '' : 's'}',
                            style: const TextStyle(
                              color: AxleColors.textMuted,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // ── Content ───────────────────────────────────────────────
            if (state.loading && state.vehicles.isEmpty)
              SliverPadding(
                padding: const EdgeInsets.all(AxleSpacing.xxl),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (_, __) => const Padding(
                      padding: EdgeInsets.only(bottom: 12),
                      child: _VehicleCardSkeleton(),
                    ),
                    childCount: 6,
                  ),
                ),
              )
            else if (state.errorMessage != null && state.vehicles.isEmpty)
              SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.error_outline_rounded,
                          color: AxleColors.critical, size: 32),
                      const SizedBox(height: 10),
                      Text(
                        state.errorMessage!,
                        style: const TextStyle(color: AxleColors.critical),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              )
            else if (vehicles.isEmpty)
              const SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.local_shipping_outlined,
                          color: AxleColors.textMuted, size: 32),
                      SizedBox(height: 10),
                      Text(
                        'No vehicles match your search',
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
                      final vehicle = vehicles[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: _VehicleCard(
                          name: vehicle.name ??
                              vehicle.plateNumber ??
                              vehicle.id,
                          plate: vehicle.plateNumber ?? '-',
                          online: vehicle.online,
                          feedStatus: feedStatusMap[vehicle.id],
                          feedLoading: feedAsync.isLoading,
                          onTap: () {
                            ref
                                .read(selectedVehicleIdProvider.notifier)
                                .state = vehicle.id;
                            context.push('/vehicles/${vehicle.id}');
                          },
                          onTrackTap: () {
                            ref
                                .read(selectedVehicleIdProvider.notifier)
                                .state = vehicle.id;
                            context.go('/tracking');
                          },
                          onVideoTap: () {
                            ref
                                .read(selectedVehicleIdProvider.notifier)
                                .state = vehicle.id;
                            context.go('/video');
                          },
                        ),
                      );
                    },
                    childCount: vehicles.length,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ── Vehicle Card ──────────────────────────────────────────────────────────────

class _VehicleCard extends StatefulWidget {
  const _VehicleCard({
    required this.name,
    required this.plate,
    required this.online,
    required this.feedStatus,
    required this.feedLoading,
    required this.onTap,
    required this.onTrackTap,
    required this.onVideoTap,
  });

  final String name;
  final String plate;
  final bool online;
  final MapFeedStatus? feedStatus;
  final bool feedLoading;
  final VoidCallback onTap;
  final VoidCallback onTrackTap;
  final VoidCallback onVideoTap;

  @override
  State<_VehicleCard> createState() => _VehicleCardState();
}

class _VehicleCardState extends State<_VehicleCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final borderColor = widget.online
        ? AxleColors.accent.withValues(alpha: 0.25)
        : AxleColors.textMuted.withValues(alpha: 0.15);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(AxleRadius.xl),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          decoration: BoxDecoration(
            gradient: AxleColors.cardGradient,
            borderRadius: BorderRadius.circular(AxleRadius.xl),
            border: Border.all(
              color: _hovered
                  ? (widget.online
                      ? AxleColors.accent.withValues(alpha: 0.4)
                      : AxleColors.borderLight)
                  : borderColor,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black
                    .withValues(alpha: _hovered ? 0.4 : 0.25),
                blurRadius: _hovered ? 24 : 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              // Left status bar
              Container(
                width: 3,
                height: 72,
                decoration: BoxDecoration(
                  color: widget.online
                      ? AxleColors.accent.withValues(alpha: 0.8)
                      : AxleColors.textMuted.withValues(alpha: 0.3),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(AxleRadius.xl),
                    bottomLeft: Radius.circular(AxleRadius.xl),
                  ),
                ),
              ),
              const SizedBox(width: 14),

              // Vehicle icon
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: widget.online
                      ? AxleColors.accentDim
                      : AxleColors.textMuted.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Icon(
                  Icons.local_shipping_rounded,
                  color: widget.online
                      ? AxleColors.accent
                      : AxleColors.textMuted,
                  size: 20,
                ),
              ),
              const SizedBox(width: 14),

              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            widget.name,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: AxleColors.textPrimary,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        StatusPill(online: widget.online),
                      ],
                    ),
                    const SizedBox(height: 4),
                    if (widget.feedStatus != null)
                      Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        children: [
                          _InfoChip(
                            icon: Icons.credit_card_rounded,
                            label: widget.plate,
                          ),
                          _InfoChip(
                            icon: Icons.speed_rounded,
                            label:
                                '${widget.feedStatus!.speedKmh.toStringAsFixed(0)} km/h',
                            color: widget.feedStatus!.speedKmh > 0
                                ? AxleColors.accent
                                : null,
                          ),
                          _InfoChip(
                            icon: Icons.access_time_rounded,
                            label: DateTimeUtils.formatDateTime(
                                widget.feedStatus!.updatedAt),
                          ),
                        ],
                      )
                    else if (widget.feedLoading)
                      const Row(
                        children: [
                          AxleSkeleton(width: 70, height: 20),
                          SizedBox(width: 8),
                          AxleSkeleton(width: 60, height: 20),
                          SizedBox(width: 8),
                          AxleSkeleton(width: 110, height: 20),
                        ],
                      )
                    else
                      Text(
                        '${widget.plate} · Status unavailable',
                        style: const TextStyle(
                          color: AxleColors.textMuted,
                          fontSize: 12,
                        ),
                      ),
                  ],
                ),
              ),

              // Action buttons
              Padding(
                padding: const EdgeInsets.only(right: 14),
                child: Row(
                  children: [
                    _ActionIconBtn(
                      icon: Icons.map_rounded,
                      tooltip: 'Live Map',
                      color: AxleColors.accent,
                      onTap: widget.onTrackTap,
                    ),
                    const SizedBox(width: 6),
                    _ActionIconBtn(
                      icon: Icons.videocam_rounded,
                      tooltip: 'Live Video',
                      color: AxleColors.info,
                      onTap: widget.onVideoTap,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Info Chip ─────────────────────────────────────────────────────────────────

class _InfoChip extends StatelessWidget {
  const _InfoChip({
    required this.icon,
    required this.label,
    this.color,
  });

  final IconData icon;
  final String label;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final c = color ?? AxleColors.textSecondary;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: AxleColors.bgElevated,
        borderRadius: BorderRadius.circular(AxleRadius.sm),
        border: Border.all(color: AxleColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 11, color: c),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: c,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Action Icon Button ────────────────────────────────────────────────────────

class _ActionIconBtn extends StatelessWidget {
  const _ActionIconBtn({
    required this.icon,
    required this.tooltip,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String tooltip;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: color.withValues(alpha: 0.2)),
          ),
          child: Icon(icon, size: 15, color: color),
        ),
      ),
    );
  }
}

// ── Filter Chip ───────────────────────────────────────────────────────────────

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.count,
    required this.selected,
    required this.onTap,
    this.activeColor,
  });

  final String label;
  final int count;
  final bool selected;
  final VoidCallback onTap;
  final Color? activeColor;

  @override
  Widget build(BuildContext context) {
    final c = activeColor ?? AxleColors.accent;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(100),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? c.withValues(alpha: 0.12) : AxleColors.bgElevated,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: selected
                ? c.withValues(alpha: 0.3)
                : AxleColors.border,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                color: selected ? c : AxleColors.textSecondary,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 5),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
              decoration: BoxDecoration(
                color: selected
                    ? c.withValues(alpha: 0.2)
                    : AxleColors.bgHover,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Text(
                count.toString(),
                style: TextStyle(
                  color: selected ? c : AxleColors.textMuted,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Skeleton card ─────────────────────────────────────────────────────────────

class _VehicleCardSkeleton extends StatelessWidget {
  const _VehicleCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      decoration: axleGlassCard(),
      child: Row(
        children: [
          Container(
            width: 3,
            decoration: BoxDecoration(
              color: AxleColors.bgHover,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AxleRadius.xl),
                bottomLeft: Radius.circular(AxleRadius.xl),
              ),
            ),
          ),
          const SizedBox(width: 14),
          const AxleSkeleton(width: 42, height: 42),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                AxleSkeleton(width: 140, height: 14),
                SizedBox(height: 8),
                AxleSkeleton(width: 220, height: 12),
              ],
            ),
          ),
          const SizedBox(width: 14),
          const AxleSkeleton(width: 72, height: 32),
          const SizedBox(width: 14),
        ],
      ),
    );
  }
}
