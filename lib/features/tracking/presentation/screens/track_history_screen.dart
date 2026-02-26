import 'dart:async';

import 'package:axle_tracking_cms/core/config/env.dart';
import 'package:axle_tracking_cms/core/theme/design_system.dart';
import 'package:axle_tracking_cms/core/utils/date_time_utils.dart';
import 'package:axle_tracking_cms/core/utils/google_maps_web_loader.dart';
import 'package:axle_tracking_cms/core/utils/map_utils.dart';
import 'package:axle_tracking_cms/core/widgets/axle_widgets.dart';
import 'package:axle_tracking_cms/features/tracking/domain/entities/track_history.dart';
import 'package:axle_tracking_cms/features/tracking/presentation/controllers/track_history_controller.dart';
import 'package:axle_tracking_cms/features/tracking/presentation/providers/tracking_providers.dart';
import 'package:axle_tracking_cms/features/vehicles/domain/entities/vehicle.dart';
import 'package:axle_tracking_cms/features/vehicles/presentation/providers/vehicles_providers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrackHistoryScreen extends ConsumerStatefulWidget {
  const TrackHistoryScreen({super.key});

  @override
  ConsumerState<TrackHistoryScreen> createState() => _TrackHistoryScreenState();
}

class _TrackHistoryScreenState extends ConsumerState<TrackHistoryScreen> {
  String? _selectedVehicleId;
  Timer? _playTimer;
  bool _playing = false;
  double _progress = 0;
  int _speedIndex = 0;

  static const _speeds = [1, 2, 4];

  @override
  void dispose() {
    _playTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vehiclesState = ref.watch(vehiclesControllerProvider);
    final vehicles = vehiclesState.vehicles;
    final selectedId =
        _selectedVehicleId ?? (vehicles.isNotEmpty ? vehicles.first.id : null);
    final selectedVehicle = _findVehicle(vehicles, selectedId);

    final trackState = selectedId == null
        ? null
        : ref.watch(trackHistoryControllerProvider(selectedId));
    final trackController = selectedId == null
        ? null
        : ref.read(trackHistoryControllerProvider(selectedId).notifier);

    final history = trackState?.history;
    final points = history?.points ?? const <TrackPoint>[];

    final currentIndex = points.isEmpty
        ? 0
        : (_progress * (points.length - 1)).clamp(0, points.length - 1).toInt();
    final currentPoint = points.isEmpty ? null : points[currentIndex];
    final currentTime = currentPoint == null
        ? '-'
        : DateTimeUtils.formatDateTime(currentPoint.recordedAt);

    return AxleBackground(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 1040;

          return Padding(
            padding: const EdgeInsets.all(AxleSpacing.lg),
            child: isWide
                ? Row(
                    children: [
                      SizedBox(
                        width: 300,
                        child: _PlaybackVehiclePanel(
                          vehicles: vehicles,
                          selectedVehicleId: selectedId,
                          onSelect: (id) {
                            _stopPlayback();
                            setState(() {
                              _selectedVehicleId = id;
                              _progress = 0;
                            });
                            ref
                                .read(
                                    trackHistoryControllerProvider(id).notifier)
                                .fetch();
                          },
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          children: [
                            _PlaybackToolbar(
                              vehicleName: selectedVehicle?.name ??
                                  selectedVehicle?.plateNumber ??
                                  'No vehicle selected',
                              rangeText:
                                  _rangeText(trackState?.from, trackState?.to),
                              onPickRange: trackController == null
                                  ? null
                                  : () => _pickRange(
                                        context: context,
                                        controller: trackController,
                                        from: trackState?.from,
                                        to: trackState?.to,
                                      ),
                              onLoad: trackController == null
                                  ? null
                                  : () {
                                      _stopPlayback();
                                      setState(() => _progress = 0);
                                      trackController.fetch();
                                    },
                            ),
                            const SizedBox(height: 12),
                            Expanded(
                              child: _PlaybackMap(
                                history: history,
                                progress: _progress,
                                loading: trackState?.loading == true,
                                error: trackState?.errorMessage,
                              ),
                            ),
                            const SizedBox(height: 12),
                            _PlaybackControls(
                              progress: _progress,
                              speed: _speeds[_speedIndex],
                              currentTime: currentTime,
                              disabled: points.length < 2,
                              playing: _playing,
                              onSeek: (value) =>
                                  setState(() => _progress = value),
                              onPlayPause:
                                  points.length < 2 ? null : _togglePlay,
                              onReset: () {
                                _stopPlayback();
                                setState(() => _progress = 0);
                              },
                              onChangeSpeed: () {
                                setState(() {
                                  _speedIndex =
                                      (_speedIndex + 1) % _speeds.length;
                                });
                                if (_playing) {
                                  _stopPlayback();
                                  _startPlayback();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      _PlaybackToolbar(
                        vehicleName: selectedVehicle?.name ??
                            selectedVehicle?.plateNumber ??
                            'No vehicle selected',
                        rangeText: _rangeText(trackState?.from, trackState?.to),
                        onPickRange: trackController == null
                            ? null
                            : () => _pickRange(
                                  context: context,
                                  controller: trackController,
                                  from: trackState?.from,
                                  to: trackState?.to,
                                ),
                        onLoad: trackController == null
                            ? null
                            : () {
                                _stopPlayback();
                                setState(() => _progress = 0);
                                trackController.fetch();
                              },
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 110,
                        child: _PlaybackVehiclePanel(
                          vehicles: vehicles,
                          selectedVehicleId: selectedId,
                          compact: true,
                          onSelect: (id) {
                            _stopPlayback();
                            setState(() {
                              _selectedVehicleId = id;
                              _progress = 0;
                            });
                            ref
                                .read(
                                    trackHistoryControllerProvider(id).notifier)
                                .fetch();
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: _PlaybackMap(
                          history: history,
                          progress: _progress,
                          loading: trackState?.loading == true,
                          error: trackState?.errorMessage,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _PlaybackControls(
                        progress: _progress,
                        speed: _speeds[_speedIndex],
                        currentTime: currentTime,
                        disabled: points.length < 2,
                        playing: _playing,
                        onSeek: (value) => setState(() => _progress = value),
                        onPlayPause: points.length < 2 ? null : _togglePlay,
                        onReset: () {
                          _stopPlayback();
                          setState(() => _progress = 0);
                        },
                        onChangeSpeed: () {
                          setState(() {
                            _speedIndex = (_speedIndex + 1) % _speeds.length;
                          });
                          if (_playing) {
                            _stopPlayback();
                            _startPlayback();
                          }
                        },
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }

  Vehicle? _findVehicle(List<Vehicle> vehicles, String? id) {
    if (id == null) return null;
    for (final vehicle in vehicles) {
      if (vehicle.id == id) return vehicle;
    }
    return null;
  }

  String _rangeText(DateTime? from, DateTime? to) {
    if (from == null || to == null) return 'No range selected';
    return '${DateTimeUtils.formatDateTime(from)}  ->  ${DateTimeUtils.formatDateTime(to)}';
  }

  Future<void> _pickRange({
    required BuildContext context,
    required TrackHistoryController controller,
    required DateTime? from,
    required DateTime? to,
  }) async {
    final now = DateTime.now();
    final range = await showDateRangePicker(
      context: context,
      firstDate: now.subtract(const Duration(days: 45)),
      lastDate: now,
      initialDateRange: DateTimeRange(
        start: from ?? now.subtract(const Duration(hours: 6)),
        end: to ?? now,
      ),
    );

    if (range == null) return;

    controller.setRange(
      from: DateTime(range.start.year, range.start.month, range.start.day),
      to: DateTime(range.end.year, range.end.month, range.end.day, 23, 59, 59),
    );
  }

  void _togglePlay() {
    if (_playing) {
      _stopPlayback();
    } else {
      _startPlayback();
    }
  }

  void _startPlayback() {
    _stopPlayback();
    setState(() => _playing = true);

    final step = (0.012 * _speeds[_speedIndex]).clamp(0.004, 0.08);
    _playTimer = Timer.periodic(const Duration(milliseconds: 350), (_) {
      if (!mounted) return;
      setState(() {
        _progress += step;
        if (_progress >= 1) {
          _progress = 1;
          _stopPlayback();
        }
      });
    });
  }

  void _stopPlayback() {
    _playTimer?.cancel();
    _playTimer = null;
    if (_playing && mounted) {
      setState(() => _playing = false);
    }
  }
}

class _PlaybackToolbar extends StatelessWidget {
  const _PlaybackToolbar({
    required this.vehicleName,
    required this.rangeText,
    required this.onPickRange,
    required this.onLoad,
  });

  final String vehicleName;
  final String rangeText;
  final VoidCallback? onPickRange;
  final VoidCallback? onLoad;

  @override
  Widget build(BuildContext context) {
    return AxleGlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$vehicleName • Route Playback',
            style: const TextStyle(
              color: AxleColors.textPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            rangeText,
            style:
                const TextStyle(color: AxleColors.textSecondary, fontSize: 11),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              OutlinedButton.icon(
                onPressed: onPickRange,
                icon: const Icon(Icons.date_range_rounded, size: 16),
                label: const Text('Date Range'),
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                onPressed: onLoad,
                icon: const Icon(Icons.cloud_download_rounded, size: 16),
                label: const Text('Load Route'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PlaybackVehiclePanel extends StatelessWidget {
  const _PlaybackVehiclePanel({
    required this.vehicles,
    required this.selectedVehicleId,
    required this.onSelect,
    this.compact = false,
  });

  final List<Vehicle> vehicles;
  final String? selectedVehicleId;
  final ValueChanged<String> onSelect;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    if (compact) {
      return AxleGlassCard(
        padding: const EdgeInsets.all(10),
        child: ListView.separated(
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
                width: 170,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color:
                      selected ? AxleColors.accentDim : AxleColors.bgElevated,
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
                    Text(
                      vehicle.name ?? vehicle.plateNumber ?? vehicle.id,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AxleColors.textPrimary,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      vehicle.plateNumber ?? '-',
                      style: const TextStyle(
                          color: AxleColors.textSecondary, fontSize: 10),
                    ),
                    const Spacer(),
                    StatusPill(online: vehicle.online),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }

    return AxleGlassCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(14, 14, 14, 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Vehicles',
                style: TextStyle(
                  color: AxleColors.textPrimary,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
            ),
          ),
          const Divider(height: 1, color: AxleColors.border),
          Expanded(
            child: ListView.builder(
              itemCount: vehicles.length,
              itemBuilder: (context, index) {
                final vehicle = vehicles[index];
                final selected = vehicle.id == selectedVehicleId;
                return InkWell(
                  onTap: () => onSelect(vehicle.id),
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      color:
                          selected ? AxleColors.accentDim : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: selected
                            ? AxleColors.accent.withValues(alpha: 0.24)
                            : Colors.transparent,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          vehicle.name ?? vehicle.plateNumber ?? vehicle.id,
                          style: const TextStyle(
                            color: AxleColors.textPrimary,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          vehicle.plateNumber ?? '-',
                          style: const TextStyle(
                              color: AxleColors.textSecondary, fontSize: 10),
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

class _PlaybackMap extends StatelessWidget {
  const _PlaybackMap({
    required this.history,
    required this.progress,
    required this.loading,
    required this.error,
  });

  final TrackHistory? history;
  final double progress;
  final bool loading;
  final String? error;

  @override
  Widget build(BuildContext context) {
    final points = history?.points ?? const <TrackPoint>[];

    if (loading) {
      return const AxleGlassCard(
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (error != null) {
      return AxleGlassCard(
        child: Center(
          child: Text(
            error!,
            style: const TextStyle(color: AxleColors.critical),
          ),
        ),
      );
    }

    if (points.isEmpty) {
      return const AxleGlassCard(
        child: Center(
          child: Text(
            'Load a range to visualize route playback.',
            style: TextStyle(color: AxleColors.textMuted),
          ),
        ),
      );
    }

    final coordinates = points
        .map((point) => normalizeVehicleLatLng(point.latitude, point.longitude))
        .toList(growable: false);

    final markerPosition = _positionAtProgress(points, progress);
    final playedCoordinates = _playedPath(points, progress);

    return Container(
      decoration: axleGlassCard(),
      clipBehavior: Clip.antiAlias,
      child: kIsWeb
          ? FutureBuilder<bool>(
              future: ensureGoogleMapsWebLoaded(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.data != true) {
                  final missingKey = EnvConfig.googleMapsApiKey.isEmpty;
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        missingKey
                            ? 'Google Maps key is missing.\nSet GOOGLE_MAPS_API_KEY in .env and restart app.'
                            : 'Google Maps JS failed to initialize.\nCheck key referrer restrictions for localhost/127.0.0.1.',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: AxleColors.textSecondary),
                      ),
                    ),
                  );
                }
                return GoogleMap(
                  initialCameraPosition:
                      CameraPosition(target: markerPosition, zoom: 12),
                  style: kReadableRoadMapStyle,
                  mapType: MapType.normal,
                  compassEnabled: true,
                  buildingsEnabled: true,
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: true,
                  mapToolbarEnabled: false,
                  polylines: {
                    Polyline(
                      polylineId: const PolylineId('full'),
                      color: AxleColors.textSecondary.withValues(alpha: 0.8),
                      width: 5,
                      points: coordinates,
                    ),
                    Polyline(
                      polylineId: const PolylineId('played'),
                      color: AxleColors.accent,
                      width: 7,
                      points: playedCoordinates,
                    ),
                  },
                  markers: {
                    Marker(
                      markerId: const MarkerId('playhead'),
                      position: markerPosition,
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueGreen),
                    ),
                    Marker(
                      markerId: const MarkerId('start'),
                      position: coordinates.first,
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueAzure),
                    ),
                    Marker(
                      markerId: const MarkerId('end'),
                      position: coordinates.last,
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueRed),
                    ),
                  },
                );
              },
            )
          : GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: markerPosition, zoom: 12),
              style: kReadableRoadMapStyle,
              mapType: MapType.normal,
              compassEnabled: true,
              buildingsEnabled: true,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: true,
              mapToolbarEnabled: false,
              polylines: {
                Polyline(
                  polylineId: const PolylineId('full'),
                  color: AxleColors.textSecondary.withValues(alpha: 0.8),
                  width: 5,
                  points: coordinates,
                ),
                Polyline(
                  polylineId: const PolylineId('played'),
                  color: AxleColors.accent,
                  width: 7,
                  points: playedCoordinates,
                ),
              },
              markers: {
                Marker(
                  markerId: const MarkerId('playhead'),
                  position: markerPosition,
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueGreen),
                ),
                Marker(
                  markerId: const MarkerId('start'),
                  position: coordinates.first,
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueAzure),
                ),
                Marker(
                  markerId: const MarkerId('end'),
                  position: coordinates.last,
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueRed),
                ),
              },
            ),
    );
  }

  LatLng _positionAtProgress(List<TrackPoint> points, double progress) {
    if (points.length == 1) {
      return normalizeVehicleLatLng(
        points.first.latitude,
        points.first.longitude,
      );
    }

    final scaled = progress.clamp(0, 1) * (points.length - 1);
    final lower = scaled.floor();
    final upper = scaled.ceil();
    final t = scaled - lower;

    final a = points[lower];
    final b = points[upper];

    final lat = a.latitude + ((b.latitude - a.latitude) * t);
    final lng = a.longitude + ((b.longitude - a.longitude) * t);
    return normalizeVehicleLatLng(lat, lng);
  }

  List<LatLng> _playedPath(List<TrackPoint> points, double progress) {
    if (points.isEmpty) return const <LatLng>[];

    final scaled = progress.clamp(0, 1) * (points.length - 1);
    final index = scaled.floor();
    final path = points
        .take(index + 1)
        .map((point) => normalizeVehicleLatLng(point.latitude, point.longitude))
        .toList(growable: true);

    path.add(_positionAtProgress(points, progress));
    return path;
  }
}

class _PlaybackControls extends StatelessWidget {
  const _PlaybackControls({
    required this.progress,
    required this.speed,
    required this.currentTime,
    required this.disabled,
    required this.playing,
    required this.onSeek,
    required this.onPlayPause,
    required this.onReset,
    required this.onChangeSpeed,
  });

  final double progress;
  final int speed;
  final String currentTime;
  final bool disabled;
  final bool playing;
  final ValueChanged<double> onSeek;
  final VoidCallback? onPlayPause;
  final VoidCallback onReset;
  final VoidCallback onChangeSpeed;

  @override
  Widget build(BuildContext context) {
    return AxleGlassCard(
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'Playback Controls',
                style: TextStyle(
                  color: AxleColors.textPrimary,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
              const Spacer(),
              Text(
                currentTime,
                style: const TextStyle(
                    color: AxleColors.textSecondary, fontSize: 11),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: AxleColors.accent,
              inactiveTrackColor: AxleColors.bgElevated,
              thumbColor: AxleColors.accent,
            ),
            child: Slider(
              value: progress,
              onChanged: disabled ? null : onSeek,
            ),
          ),
          Row(
            children: [
              OutlinedButton(
                onPressed: onChangeSpeed,
                child: Text('${speed}x'),
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                onPressed: onPlayPause,
                icon: Icon(
                    playing ? Icons.pause_rounded : Icons.play_arrow_rounded,
                    size: 16),
                label: Text(playing ? 'Pause' : 'Play'),
              ),
              const SizedBox(width: 8),
              OutlinedButton(
                onPressed: onReset,
                child: const Text('Reset'),
              ),
              const Spacer(),
              if (disabled)
                const Text(
                  'Need at least 2 points',
                  style: TextStyle(color: AxleColors.textMuted, fontSize: 11),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
