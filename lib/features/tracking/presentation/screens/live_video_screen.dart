import 'dart:async';

import 'package:axle_tracking_cms/core/theme/design_system.dart';
import 'package:axle_tracking_cms/core/widgets/axle_widgets.dart';
import 'package:axle_tracking_cms/features/gateway/presentation/providers/gateway_providers.dart';
import 'package:axle_tracking_cms/features/tracking/domain/entities/live_stream_info.dart';
import 'package:axle_tracking_cms/features/tracking/domain/entities/map_feed_vehicle.dart';
import 'package:axle_tracking_cms/features/tracking/presentation/providers/tracking_providers.dart';
import 'package:axle_tracking_cms/features/tracking/presentation/widgets/cms_web_video_player.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LiveVideoScreen extends ConsumerStatefulWidget {
  const LiveVideoScreen({super.key});

  @override
  ConsumerState<LiveVideoScreen> createState() => _LiveVideoScreenState();
}

class _LiveVideoScreenState extends ConsumerState<LiveVideoScreen> {
  int _stream = 0; // 0 = sub-stream, 1 = main-stream

  bool _loadingStream = false;
  String? _loadError;
  String? _playerUrl;

  String? _lastAttemptKey;
  int _requestNonce = 0;

  @override
  Widget build(BuildContext context) {
    final feedAsync = ref.watch(mapFeedProvider);

    return AxleBackground(
      child: feedAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: AxleGlassCard(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline_rounded,
                    color: AxleColors.critical),
                const SizedBox(height: 8),
                Text('$error',
                    style: const TextStyle(color: AxleColors.critical)),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => ref.invalidate(mapFeedProvider),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
        data: (vehicles) {
          final selectedId = _resolveSelectedVehicleId(vehicles);
          _ensureVehicleStreamLoaded(selectedId);

          return Padding(
            padding: const EdgeInsets.all(AxleSpacing.lg),
            child: Column(
              children: [
                // ── Controls card ──────────────────────────────────────
                AxleGlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Row 1: title
                      Row(
                        children: [
                          const Icon(Icons.videocam_rounded,
                              size: 18, color: AxleColors.accent),
                          const SizedBox(width: 8),
                          const Text(
                            'Live Video',
                            style: TextStyle(
                              color: AxleColors.textPrimary,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Spacer(),
                          if (_loadingStream)
                            const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // Row 2: vehicle selector chips
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: vehicles
                              .map((vehicle) => Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: _VehicleChip(
                                      vehicle: vehicle,
                                      selected: vehicle.id == selectedId,
                                      onTap: () {
                                        ref
                                            .read(selectedVehicleIdProvider
                                                .notifier)
                                            .state = vehicle.id;
                                        _loadSelectedVehicleStream(vehicle.id,
                                            force: true);
                                      },
                                    ),
                                  ))
                              .toList(growable: false),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Row 3: stream quality + retry
                      Row(
                        children: [
                          DropdownButton<int>(
                            value: _stream,
                            dropdownColor: AxleColors.bgCard,
                            style: const TextStyle(
                                color: AxleColors.textPrimary),
                            items: const [
                              DropdownMenuItem(
                                  value: 1, child: Text('Main Stream')),
                              DropdownMenuItem(
                                  value: 0, child: Text('Sub Stream')),
                            ],
                            onChanged: (value) {
                              if (value == null) return;
                              setState(() => _stream = value);
                              _loadSelectedVehicleStream(selectedId,
                                  force: true);
                            },
                          ),
                          const SizedBox(width: 10),
                          OutlinedButton.icon(
                            onPressed: selectedId == null
                                ? null
                                : () => _loadSelectedVehicleStream(selectedId,
                                    force: true),
                            icon: const Icon(Icons.refresh_rounded, size: 16),
                            label: const Text('Retry'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // ── Single CMS player ───────────────────────────────────
                Expanded(
                  child: _CmsPlayer(
                    url: _playerUrl,
                    loading: _loadingStream,
                    error: _loadError,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ── Helpers ──────────────────────────────────────────────────────────────

  String? _resolveSelectedVehicleId(List<MapFeedVehicle> vehicles) {
    if (vehicles.isEmpty) return null;
    final fromState = ref.read(selectedVehicleIdProvider);
    final selected = fromState != null &&
            vehicles.any((v) => v.id == fromState)
        ? fromState
        : vehicles.first.id;
    if (fromState != selected) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        ref.read(selectedVehicleIdProvider.notifier).state = selected;
      });
    }
    return selected;
  }

  void _ensureVehicleStreamLoaded(String? vehicleId) {
    if (vehicleId == null) return;
    if (_lastAttemptKey == _streamKey(vehicleId)) return;
    _loadSelectedVehicleStream(vehicleId);
  }

  Future<void> _loadSelectedVehicleStream(
    String? vehicleId, {
    bool force = false,
  }) async {
    if (vehicleId == null) return;
    final key = _streamKey(vehicleId);
    if (!force && _lastAttemptKey == key) return;

    final requestId = ++_requestNonce;

    setState(() {
      _loadingStream = true;
      _loadError = null;
      _playerUrl = null;
      _lastAttemptKey = key;
    });

    try {
      final repo = ref.read(gatewayRepositoryProvider);
      final info = await repo.fetchLiveStream(
        vehicleId,
        channel: 1,
        stream: _stream,
      );

      if (!mounted || requestId != _requestNonce) return;

      final url = _buildPlayerUrl(info);

      setState(() {
        _playerUrl = url;
        _loadingStream = false;
        if (url == null) {
          _loadError =
              'Could not resolve stream URL. Check jsession validity and CMS connectivity.';
        }
      });
    } catch (error) {
      if (!mounted || requestId != _requestNonce) return;
      setState(() {
        _loadingStream = false;
        _loadError = '$error';
      });
    }
  }

  /// Builds the CMS H5 player URL for the selected vehicle.
  ///
  /// The CMS player handles its own multi-channel grid display internally.
  /// We embed it once and let the CMS UI manage channel switching and layout.
  String? _buildPlayerUrl(LiveStreamInfo info) {
    final sources = <String>[
      if (info.rawStreamUrl != null) info.rawStreamUrl!,
      if (info.streamUrl != null) info.streamUrl!,
      ...info.urls,
    ];

    String? host;
    String? scheme;
    int? webPort;
    String? devIdno;
    String? jsession;

    for (final raw in sources) {
      final uri = Uri.tryParse(raw.trim());
      if (uri == null || uri.host.isEmpty) continue;

      host ??= uri.host;
      scheme ??= (uri.scheme == 'https') ? 'https' : 'http';

      if (uri.hasPort && uri.port != 6604 && uri.port != 6605) {
        webPort ??= uri.port;
      }

      jsession ??= _queryValue(uri, 'jsession');
      devIdno ??= _queryValue(uri, 'DevIDNO');

      if (devIdno == null) {
        final match =
            RegExp(r'/hls/1_([^_]+)_\d+_\d+\.m3u8', caseSensitive: false)
                .firstMatch(uri.path);
        if (match != null) devIdno = match.group(1);
      }

      if (jsession != null && devIdno != null) break;
    }

    if (host == null ||
        host == 'localhost' ||
        host == '127.0.0.1' ||
        jsession == null ||
        devIdno == null) {
      return null;
    }

    final url = Uri(
      scheme: scheme ?? 'http',
      host: host,
      port: webPort,
      path: '/808gps/open/player/videoH5.html',
      queryParameters: {
        'devIdno': devIdno,
        'jsession': jsession,
        'lang': 'zh',
      },
    ).toString();

    debugPrint('[LiveVideo] player URL → $url');
    return url;
  }

  String? _queryValue(Uri uri, String key) {
    if (uri.queryParameters.containsKey(key)) return uri.queryParameters[key];
    for (final entry in uri.queryParameters.entries) {
      if (entry.key.toLowerCase() == key.toLowerCase()) return entry.value;
    }
    return null;
  }

  String _streamKey(String vehicleId) => '$vehicleId|$_stream';
}

// ── Vehicle Chip ──────────────────────────────────────────────────────────────

class _VehicleChip extends StatelessWidget {
  const _VehicleChip({
    required this.vehicle,
    required this.selected,
    required this.onTap,
  });

  final MapFeedVehicle vehicle;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? AxleColors.accentDim : AxleColors.bgElevated,
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
              style: const TextStyle(
                color: AxleColors.textPrimary,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              vehicle.plateNumber ?? vehicle.id,
              style:
                  const TextStyle(color: AxleColors.textMuted, fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}

// ── CMS Player ────────────────────────────────────────────────────────────────
// Single unified player for both web (HtmlElementView iframe) and
// mobile (WebView). The CMS H5 player manages its own channel grid internally.

class _CmsPlayer extends StatelessWidget {
  const _CmsPlayer({
    required this.url,
    required this.loading,
    this.error,
  });

  final String? url;
  final bool loading;
  final String? error;

  @override
  Widget build(BuildContext context) {
    if (loading && url == null) {
      return const Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    }

    if (error != null && url == null) {
      return Center(
        child: AxleGlassCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline_rounded,
                  color: AxleColors.critical, size: 22),
              const SizedBox(height: 8),
              Text(
                error!,
                textAlign: TextAlign.center,
                style: const TextStyle(color: AxleColors.critical, fontSize: 12),
              ),
            ],
          ),
        ),
      );
    }

    if (url == null) {
      return const Center(
        child: Text('No signal',
            style: TextStyle(color: AxleColors.textMuted, fontSize: 13)),
      );
    }

    return Container(
      decoration: axleGlassCard(radius: 12),
      clipBehavior: Clip.antiAlias,
      child: kIsWeb
          ? buildCmsWebVideoPlayer(url: url!)
          : _MobilePlayer(url: url!),
    );
  }
}

// ── Mobile Player ─────────────────────────────────────────────────────────────

class _MobilePlayer extends StatefulWidget {
  const _MobilePlayer({required this.url});

  final String url;

  @override
  State<_MobilePlayer> createState() => _MobilePlayerState();
}

class _MobilePlayerState extends State<_MobilePlayer> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _load(widget.url);
  }

  @override
  void didUpdateWidget(_MobilePlayer old) {
    super.didUpdateWidget(old);
    if (old.url != widget.url) _load(widget.url);
  }

  void _load(String url) {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xFF07090D))
      ..loadRequest(Uri.parse(url));
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: _controller);
  }
}
