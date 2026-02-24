import 'package:axle_tracking_cms/core/config/env.dart';
import 'package:flutter/foundation.dart';

import 'google_maps_web_loader_stub.dart'
    if (dart.library.html) 'google_maps_web_loader_web.dart' as impl;

Future<bool> ensureGoogleMapsWebLoaded() async {
  if (!kIsWeb) return true;
  final key = EnvConfig.googleMapsApiKey;
  if (key.isEmpty) return false;
  return impl.ensureGoogleMapsWebLoaded(key);
}

bool get isGoogleMapsWebLoaded => impl.isGoogleMapsWebLoaded;
