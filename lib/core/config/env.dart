import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart';

class EnvConfig {
  static Future<void> load() async {
    try {
      await dotenv.load(fileName: '.env');
    } catch (_) {
      // Keep running with defaults when .env is not present.
    }
  }

  static String get baseUrl {
    final value = dotenv.maybeGet('API_BASE_URL');
    final raw =
        (value == null || value.isEmpty) ? 'http://localhost:3001' : value;
    return _resolveForPlatform(raw);
  }

  static String get googleMapsApiKey {
    final value = dotenv.maybeGet('GOOGLE_MAPS_API_KEY');
    return value ?? '';
  }

  static bool get webDirectStreamOnly =>
      _readBool('WEB_DIRECT_STREAM_ONLY', defaultValue: true);

  static String _resolveForPlatform(String raw) {
    if (!kIsWeb &&
        defaultTargetPlatform == TargetPlatform.android &&
        (raw.contains('://localhost') || raw.contains('://127.0.0.1'))) {
      return raw
          .replaceAll('://localhost', '://10.0.2.2')
          .replaceAll('://127.0.0.1', '://10.0.2.2');
    }
    return raw;
  }

  static bool _readBool(
    String key, {
    required bool defaultValue,
  }) {
    final raw = dotenv.maybeGet(key);
    if (raw == null) return defaultValue;
    switch (raw.trim().toLowerCase()) {
      case '1':
      case 'true':
      case 'yes':
      case 'on':
        return true;
      case '0':
      case 'false':
      case 'no':
      case 'off':
        return false;
      default:
        return defaultValue;
    }
  }
}
