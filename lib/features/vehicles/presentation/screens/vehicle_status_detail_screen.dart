import 'package:axle_tracking_cms/core/config/env.dart';
import 'package:axle_tracking_cms/core/theme/design_system.dart';
import 'package:axle_tracking_cms/core/utils/date_time_utils.dart';
import 'package:axle_tracking_cms/core/utils/google_maps_web_loader.dart';
import 'package:axle_tracking_cms/core/utils/map_utils.dart';
import 'package:axle_tracking_cms/core/widgets/axle_widgets.dart';
import 'package:axle_tracking_cms/features/tracking/presentation/providers/tracking_providers.dart';
import 'package:axle_tracking_cms/features/vehicles/presentation/providers/vehicles_providers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class VehicleStatusDetailScreen extends ConsumerStatefulWidget {
  const VehicleStatusDetailScreen({required this.vehicleId, super.key});

  final String vehicleId;

  @override
  ConsumerState<VehicleStatusDetailScreen> createState() =>
      _VehicleStatusDetailScreenState();
}

class _VehicleStatusDetailScreenState
    extends ConsumerState<VehicleStatusDetailScreen> {
  @override
  void initState() {
    super.initState();
    Future<void>.microtask(
      () => ref
          .read(trackHistoryControllerProvider(widget.vehicleId).notifier)
          .fetch(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final status = ref.watch(vehicleStatusProvider(widget.vehicleId));
    final trackState =
        ref.watch(trackHistoryControllerProvider(widget.vehicleId));
    final trackController =
        ref.read(trackHistoryControllerProvider(widget.vehicleId).notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Vehicle Detail')),
      body: AxleBackground(
        child: ListView(
          padding: const EdgeInsets.all(AxleSpacing.lg),
          children: [
            AxleGlassCard(
              child: status.when(
                data: (data) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Vehicle ${data.vehicleId}',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const Spacer(),
                        StatusPill(online: data.online),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _StatusMapCard(
                      latitude: data.latitude,
                      longitude: data.longitude,
                      speedKmh: data.speedKmh,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Updated: ${DateTimeUtils.formatDateTime(data.updatedAt)}',
                      style: const TextStyle(color: AxleColors.textSecondary),
                    ),
                  ],
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) => Text(
                  'Failed to load status: $error',
                  style: const TextStyle(color: AxleColors.critical),
                ),
              ),
            ),
            const SizedBox(height: 12),
            AxleGlassCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Track Range',
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Text(
                    'From: ${DateTimeUtils.formatDateTime(trackState.from)}\n'
                    'To: ${DateTimeUtils.formatDateTime(trackState.to)}',
                    style: const TextStyle(color: AxleColors.textSecondary),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      OutlinedButton(
                        onPressed: () async {
                          final now = DateTime.now();
                          final start = await showDatePicker(
                            context: context,
                            firstDate: now.subtract(const Duration(days: 30)),
                            lastDate: now,
                            initialDate: trackState.from ?? now,
                          );
                          if (start != null) {
                            final from =
                                DateTime(start.year, start.month, start.day);
                            trackController.setRange(
                              from: from,
                              to: trackState.to ?? now,
                            );
                          }
                        },
                        child: const Text('From Date'),
                      ),
                      OutlinedButton(
                        onPressed: () async {
                          final now = DateTime.now();
                          final end = await showDatePicker(
                            context: context,
                            firstDate: now.subtract(const Duration(days: 30)),
                            lastDate: now,
                            initialDate: trackState.to ?? now,
                          );
                          if (end != null) {
                            final to = DateTime(
                                end.year, end.month, end.day, 23, 59, 59);
                            trackController.setRange(
                              from: trackState.from ??
                                  now.subtract(const Duration(hours: 6)),
                              to: to,
                            );
                          }
                        },
                        child: const Text('To Date'),
                      ),
                      ElevatedButton(
                        onPressed: trackState.loading
                            ? null
                            : () async {
                                final from = trackState.from;
                                final to = trackState.to;
                                if (from == null ||
                                    to == null ||
                                    from.isAfter(to)) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Invalid date range.')),
                                  );
                                  return;
                                }
                                await trackController.fetch();
                              },
                        child: const Text('Load Track'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            if (trackState.loading)
              const Center(child: CircularProgressIndicator())
            else if (trackState.errorMessage != null)
              Text(
                trackState.errorMessage!,
                style: const TextStyle(color: AxleColors.critical),
              )
            else if ((trackState.history?.points ?? const []).isEmpty)
              const Text(
                'No track points in selected range.',
                style: TextStyle(color: AxleColors.textMuted),
              )
            else
              ...trackState.history!.points.map(
                (point) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: AxleGlassCard(
                    padding: const EdgeInsets.all(AxleSpacing.md),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        '${point.latitude.toStringAsFixed(6)}, ${point.longitude.toStringAsFixed(6)}',
                        style: const TextStyle(color: AxleColors.textPrimary),
                      ),
                      subtitle: Text(
                        'Speed ${point.speedKmh.toStringAsFixed(1)} km/h\n'
                        '${DateTimeUtils.formatDateTime(point.recordedAt)}',
                        style: const TextStyle(color: AxleColors.textSecondary),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.invalidate(vehicleStatusProvider(widget.vehicleId));
          trackController.fetch();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: AxleColors.bgElevated,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AxleColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style:
                  const TextStyle(fontSize: 10, color: AxleColors.textMuted)),
          Text(value,
              style:
                  const TextStyle(fontSize: 12, color: AxleColors.textPrimary)),
        ],
      ),
    );
  }
}

class _StatusMapCard extends StatelessWidget {
  const _StatusMapCard({
    required this.latitude,
    required this.longitude,
    required this.speedKmh,
  });

  final double latitude;
  final double longitude;
  final double speedKmh;

  @override
  Widget build(BuildContext context) {
    final markerPosition = normalizeVehicleLatLng(latitude, longitude);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            height: 220,
            width: double.infinity,
            child: kIsWeb
                ? FutureBuilder<bool>(
                    future: ensureGoogleMapsWebLoaded(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.data != true) {
                        final missingKey = EnvConfig.googleMapsApiKey.isEmpty;
                        return _MapFallback(missingKey: missingKey);
                      }
                      return _GoogleMapView(markerPosition: markerPosition);
                    },
                  )
                : _GoogleMapView(markerPosition: markerPosition),
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _InfoChip(
                label: 'Speed', value: '${speedKmh.toStringAsFixed(1)} km/h'),
            _InfoChip(
              label: 'Location',
              value:
                  '${latitude.toStringAsFixed(5)}, ${longitude.toStringAsFixed(5)}',
            ),
          ],
        ),
      ],
    );
  }
}

class _MapFallback extends StatelessWidget {
  const _MapFallback({required this.missingKey});

  final bool missingKey;

  @override
  Widget build(BuildContext context) {
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
}

class _GoogleMapView extends StatelessWidget {
  const _GoogleMapView({required this.markerPosition});

  final LatLng markerPosition;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(target: markerPosition, zoom: 14),
      style: kReadableRoadMapStyle,
      mapType: MapType.normal,
      compassEnabled: true,
      buildingsEnabled: true,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: true,
      mapToolbarEnabled: false,
      markers: {
        Marker(
          markerId: const MarkerId('vehicle_status_marker'),
          position: markerPosition,
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        ),
      },
    );
  }
}
