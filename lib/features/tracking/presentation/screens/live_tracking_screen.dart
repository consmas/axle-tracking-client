import 'dart:async';

import 'package:axle_tracking_cms/core/config/env.dart';
import 'package:axle_tracking_cms/core/theme/design_system.dart';
import 'package:axle_tracking_cms/core/utils/google_maps_web_loader.dart';
import 'package:axle_tracking_cms/core/utils/date_time_utils.dart';
import 'package:axle_tracking_cms/core/widgets/axle_widgets.dart';
import 'package:axle_tracking_cms/features/tracking/domain/entities/map_feed_vehicle.dart';
import 'package:axle_tracking_cms/features/tracking/presentation/providers/tracking_providers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LiveTrackingScreen extends ConsumerStatefulWidget {
  const LiveTrackingScreen({super.key});

  @override
  ConsumerState<LiveTrackingScreen> createState() => _LiveTrackingScreenState();
}

class _LiveTrackingScreenState extends ConsumerState<LiveTrackingScreen> {
  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    _refreshTimer = Timer.periodic(const Duration(seconds: 10), (_) {
      if (!mounted) return;
      ref.invalidate(mapFeedProvider);
    });
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final feedAsync = ref.watch(mapFeedProvider);

    return feedAsync.when(
      data: (vehicles) => _buildLoaded(context, vehicles),
      loading: () => AxleBackground(
        child: Center(
          child: AxleGlassCard(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                CircularProgressIndicator(),
                SizedBox(height: 10),
                Text('Loading map feed...'),
              ],
            ),
          ),
        ),
      ),
      error: (error, _) => AxleBackground(
        child: Center(
          child: AxleGlassCard(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline_rounded,
                    color: AxleColors.critical),
                const SizedBox(height: 8),
                Text(
                  '$error',
                  style: const TextStyle(color: AxleColors.critical),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => ref.invalidate(mapFeedProvider),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoaded(BuildContext context, List<MapFeedVehicle> vehicles) {
    final selectedFromState = ref.watch(selectedVehicleIdProvider);
    final selectedId = selectedFromState != null &&
            vehicles.any((vehicle) => vehicle.id == selectedFromState)
        ? selectedFromState
        : (vehicles.isNotEmpty ? vehicles.first.id : null);

    if (selectedId != null && selectedId != selectedFromState) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        ref.read(selectedVehicleIdProvider.notifier).state = selectedId;
      });
    }

    final selectedVehicle = _findVehicle(vehicles, selectedId);
    final markerPosition = selectedVehicle == null
        ? const LatLng(25.2048, 55.2708)
        : LatLng(
            selectedVehicle.status.latitude, selectedVehicle.status.longitude);

    final markers = <Marker>{
      ...vehicles.map(
        (vehicle) => Marker(
          markerId: MarkerId('vehicle_${vehicle.id}'),
          position: LatLng(vehicle.status.latitude, vehicle.status.longitude),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            vehicle.id == selectedId
                ? BitmapDescriptor.hueGreen
                : (vehicle.online
                    ? BitmapDescriptor.hueAzure
                    : BitmapDescriptor.hueRed),
          ),
          infoWindow: InfoWindow(
              title: vehicle.name ?? vehicle.plateNumber ?? vehicle.id),
          zIndexInt: vehicle.id == selectedId ? 2 : 1,
        ),
      ),
    };

    return AxleBackground(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 1000;
          return Padding(
            padding: const EdgeInsets.all(AxleSpacing.lg),
            child: isWide
                ? Row(
                    children: [
                      SizedBox(
                        width: 330,
                        child: _VehicleList(
                          vehicles: vehicles,
                          selectedVehicleId: selectedId,
                          onSelect: (id) => ref
                              .read(selectedVehicleIdProvider.notifier)
                              .state = id,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: _MapPanel(
                          markers: markers,
                          markerPosition: markerPosition,
                          selectedVehicle: selectedVehicle,
                          onOpenPlayback: selectedId == null
                              ? null
                              : () => context.go('/playback'),
                          onOpenVideo: () => context.go('/video'),
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      SizedBox(
                        height: 124,
                        child: _VehicleListCompact(
                          vehicles: vehicles,
                          selectedVehicleId: selectedId,
                          onSelect: (id) => ref
                              .read(selectedVehicleIdProvider.notifier)
                              .state = id,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: _MapPanel(
                          markers: markers,
                          markerPosition: markerPosition,
                          selectedVehicle: selectedVehicle,
                          onOpenPlayback: selectedId == null
                              ? null
                              : () => context.go('/playback'),
                          onOpenVideo: () => context.go('/video'),
                        ),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }

  MapFeedVehicle? _findVehicle(List<MapFeedVehicle> vehicles, String? id) {
    if (id == null) return null;
    for (final vehicle in vehicles) {
      if (vehicle.id == id) return vehicle;
    }
    return null;
  }
}

class _VehicleList extends StatelessWidget {
  const _VehicleList({
    required this.vehicles,
    required this.selectedVehicleId,
    required this.onSelect,
  });

  final List<MapFeedVehicle> vehicles;
  final String? selectedVehicleId;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    return AxleGlassCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(14, 14, 14, 10),
            child: Row(
              children: [
                Icon(Icons.radar_rounded, size: 16, color: AxleColors.accent),
                SizedBox(width: 8),
                Text(
                  'Fleet Vehicles',
                  style: TextStyle(
                    color: AxleColors.textPrimary,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: AxleColors.border),
          Expanded(
            child: vehicles.isEmpty
                ? const Center(
                    child: Text(
                      'No vehicles available',
                      style: TextStyle(color: AxleColors.textMuted),
                    ),
                  )
                : ListView.builder(
                    itemCount: vehicles.length,
                    itemBuilder: (context, index) {
                      final vehicle = vehicles[index];
                      final selected = vehicle.id == selectedVehicleId;
                      return InkWell(
                        onTap: () => onSelect(vehicle.id),
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                            color: selected
                                ? AxleColors.accentDim
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: selected
                                  ? AxleColors.accent.withValues(alpha: 0.24)
                                  : Colors.transparent,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 9,
                                height: 9,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: vehicle.online
                                      ? AxleColors.accent
                                      : AxleColors.textMuted,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      vehicle.name ??
                                          vehicle.plateNumber ??
                                          vehicle.id,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: AxleColors.textPrimary,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 1),
                                    Text(
                                      '${vehicle.plateNumber ?? vehicle.id} · ${vehicle.status.speedKmh.toStringAsFixed(0)} km/h',
                                      style: const TextStyle(
                                        color: AxleColors.textMuted,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  StatusPill(online: vehicle.online),
                                  const SizedBox(height: 4),
                                  _StreamPill(hasStream: _hasStream(vehicle)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _VehicleListCompact extends StatelessWidget {
  const _VehicleListCompact({
    required this.vehicles,
    required this.selectedVehicleId,
    required this.onSelect,
  });

  final List<MapFeedVehicle> vehicles;
  final String? selectedVehicleId;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    return AxleGlassCard(
      padding: const EdgeInsets.all(10),
      child: vehicles.isEmpty
          ? const Center(
              child: Text(
                'No vehicles available',
                style: TextStyle(color: AxleColors.textMuted),
              ),
            )
          : ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: vehicles.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final vehicle = vehicles[index];
                final selected = vehicle.id == selectedVehicleId;
                return InkWell(
                  onTap: () => onSelect(vehicle.id),
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: 190,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: selected
                          ? AxleColors.accentDim
                          : AxleColors.bgElevated,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: selected
                            ? AxleColors.accent.withValues(alpha: 0.24)
                            : AxleColors.border,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            StatusPill(online: vehicle.online),
                            const SizedBox(width: 6),
                            _StreamPill(hasStream: _hasStream(vehicle)),
                          ],
                        ),
                        const Spacer(),
                        Text(
                          vehicle.name ?? vehicle.plateNumber ?? vehicle.id,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AxleColors.textPrimary,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 1),
                        Text(
                          '${vehicle.plateNumber ?? vehicle.id} · ${vehicle.status.speedKmh.toStringAsFixed(0)} km/h',
                          style: const TextStyle(
                            color: AxleColors.textSecondary,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class _MapPanel extends StatelessWidget {
  const _MapPanel({
    required this.markers,
    required this.markerPosition,
    required this.selectedVehicle,
    required this.onOpenPlayback,
    required this.onOpenVideo,
  });

  final Set<Marker> markers;
  final LatLng markerPosition;
  final MapFeedVehicle? selectedVehicle;
  final VoidCallback? onOpenPlayback;
  final VoidCallback onOpenVideo;

  @override
  Widget build(BuildContext context) {
    final status = selectedVehicle?.status;

    return Container(
      decoration: axleGlassCard(),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned.fill(
            child: _MapSurface(
              markers: markers,
              markerPosition: markerPosition,
            ),
          ),
          Positioned(
            top: 14,
            right: 14,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: AxleColors.bg.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AxleColors.border),
              ),
              child: const Row(
                children: [
                  _LiveDot(),
                  SizedBox(width: 6),
                  Text(
                    'LIVE',
                    style: TextStyle(
                      color: AxleColors.accent,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 14,
            right: 14,
            bottom: 14,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AxleColors.bgSidebar.withValues(alpha: 0.96),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AxleColors.borderCard),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.5),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (selectedVehicle != null) ...[
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: selectedVehicle!.online
                                ? AxleColors.accentDim
                                : AxleColors.textMuted.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.local_shipping_rounded,
                            size: 18,
                            color: selectedVehicle!.online
                                ? AxleColors.accent
                                : AxleColors.textMuted,
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              selectedVehicle?.name ??
                                  selectedVehicle?.plateNumber ??
                                  'Select a vehicle',
                              style: const TextStyle(
                                color: AxleColors.textPrimary,
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (selectedVehicle?.plateNumber != null)
                              Text(
                                selectedVehicle!.plateNumber!,
                                style: const TextStyle(
                                    color: AxleColors.textMuted, fontSize: 11),
                              ),
                          ],
                        ),
                      ),
                      if (selectedVehicle != null)
                        StatusPill(online: selectedVehicle!.online),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: [
                      _MetaChip(
                        icon: Icons.speed_rounded,
                        label: 'Speed',
                        value:
                            '${status?.speedKmh.toStringAsFixed(1) ?? '-'} km/h',
                        highlight: (status?.speedKmh ?? 0) > 0,
                      ),
                      _MetaChip(
                        icon: Icons.access_time_rounded,
                        label: 'Updated',
                        value: DateTimeUtils.formatDateTime(status?.updatedAt),
                      ),
                      _MetaChip(
                        icon: Icons.location_on_rounded,
                        label: 'Coords',
                        value:
                            '${markerPosition.latitude.toStringAsFixed(5)}, ${markerPosition.longitude.toStringAsFixed(5)}',
                      ),
                      _MetaChip(
                        icon: Icons.videocam_rounded,
                        label: 'Stream',
                        value: _hasStream(selectedVehicle)
                            ? 'Available'
                            : 'Unavailable',
                        highlight: _hasStream(selectedVehicle),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 38,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: onOpenPlayback != null
                                  ? AxleColors.accentGradient
                                  : null,
                              color: onOpenPlayback == null
                                  ? AxleColors.accent.withValues(alpha: 0.3)
                                  : null,
                              borderRadius:
                                  BorderRadius.circular(AxleRadius.lg),
                            ),
                            child: ElevatedButton.icon(
                              onPressed: onOpenPlayback,
                              icon: const Icon(Icons.play_circle_fill_rounded,
                                  size: 15),
                              label: const Text('Playback'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: SizedBox(
                          height: 38,
                          child: OutlinedButton.icon(
                            onPressed: onOpenVideo,
                            icon: const Icon(Icons.videocam_rounded, size: 15),
                            label: const Text('Video'),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                  color:
                                      AxleColors.info.withValues(alpha: 0.4)),
                              foregroundColor: AxleColors.info,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                            ),
                          ),
                        ),
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
}

class _MapSurface extends StatelessWidget {
  const _MapSurface({
    required this.markers,
    required this.markerPosition,
  });

  final Set<Marker> markers;
  final LatLng markerPosition;

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return FutureBuilder<bool>(
        future: ensureGoogleMapsWebLoaded(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.data != true) {
            final missingKey = EnvConfig.googleMapsApiKey.isEmpty;
            return Container(
              color: AxleColors.bgElevated,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16),
              child: Text(
                missingKey
                    ? 'Google Maps key is missing.\nSet GOOGLE_MAPS_API_KEY in .env and restart app.'
                    : 'Google Maps JS failed to initialize.\nCheck key referrer restrictions for localhost/127.0.0.1.',
                textAlign: TextAlign.center,
                style: const TextStyle(color: AxleColors.textSecondary),
              ),
            );
          }

          return GoogleMap(
            initialCameraPosition:
                CameraPosition(target: markerPosition, zoom: 13.5),
            mapType: MapType.normal,
            compassEnabled: true,
            buildingsEnabled: true,
            markers: markers,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: true,
            mapToolbarEnabled: false,
          );
        },
      );
    }

    return GoogleMap(
      initialCameraPosition: CameraPosition(target: markerPosition, zoom: 13.5),
      mapType: MapType.normal,
      compassEnabled: true,
      buildingsEnabled: true,
      markers: markers,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: true,
      mapToolbarEnabled: false,
    );
  }
}

class _MetaChip extends StatelessWidget {
  const _MetaChip({
    required this.label,
    required this.value,
    this.icon,
    this.highlight = false,
  });

  final String label;
  final String value;
  final IconData? icon;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    final valueColor = highlight ? AxleColors.accent : AxleColors.textPrimary;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: AxleColors.bgElevated,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AxleColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 11, color: AxleColors.textMuted),
            const SizedBox(width: 5),
          ],
          Text(
            '$label: ',
            style: const TextStyle(
              color: AxleColors.textMuted,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            value,
            style: TextStyle(color: valueColor, fontSize: 11),
          ),
        ],
      ),
    );
  }
}

class _StreamPill extends StatelessWidget {
  const _StreamPill({required this.hasStream});

  final bool hasStream;

  @override
  Widget build(BuildContext context) {
    final color = hasStream ? AxleColors.info : AxleColors.textMuted;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        hasStream ? 'VIDEO' : 'NO VIDEO',
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w700,
          color: color,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

bool _hasStream(MapFeedVehicle? vehicle) {
  final stream = vehicle?.liveStream;
  if (stream == null) return false;
  return (stream.streamUrl?.isNotEmpty ?? false) ||
      (stream.stream?.isNotEmpty ?? false);
}

class _LiveDot extends StatefulWidget {
  const _LiveDot();

  @override
  State<_LiveDot> createState() => _LiveDotState();
}

class _LiveDotState extends State<_LiveDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
      lowerBound: 0.35,
      upperBound: 1,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: Container(
        width: 8,
        height: 8,
        decoration: const BoxDecoration(
          color: AxleColors.accent,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
