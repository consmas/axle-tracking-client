import 'package:google_maps_flutter/google_maps_flutter.dart';

const String kReadableRoadMapStyle = '''
[
  {"featureType":"all","elementType":"labels","stylers":[{"visibility":"on"}]},
  {"featureType":"road","elementType":"all","stylers":[{"visibility":"on"}]},
  {"featureType":"poi","elementType":"labels","stylers":[{"visibility":"on"}]},
  {"featureType":"transit","elementType":"labels","stylers":[{"visibility":"on"}]}
]
''';

LatLng normalizeVehicleLatLng(double latitude, double longitude) {
  var lat = latitude;
  var lng = longitude;

  final directValid = _isValidLatLng(lat, lng);
  final swappedValid = _isValidLatLng(lng, lat);

  if (!directValid && swappedValid) {
    final nextLat = lng;
    final nextLng = lat;
    lat = nextLat;
    lng = nextLng;
  }

  return LatLng(
    _clamp(lat, -90, 90),
    _clamp(lng, -180, 180),
  );
}

bool _isValidLatLng(double latitude, double longitude) {
  return latitude >= -90 &&
      latitude <= 90 &&
      longitude >= -180 &&
      longitude <= 180;
}

double _clamp(double value, double min, double max) {
  if (value < min) return min;
  if (value > max) return max;
  return value;
}
