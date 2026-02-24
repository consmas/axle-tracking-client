// ignore_for_file: deprecated_member_use, avoid_web_libraries_in_flutter

import 'dart:async';
import 'dart:html' as html;
import 'dart:js' as js;

Completer<bool>? _loaderCompleter;

Future<bool> ensureGoogleMapsWebLoaded(String apiKey) async {
  if (_hasGoogleMaps()) return true;
  if (apiKey.isEmpty) return false;
  if (_loaderCompleter != null) return _loaderCompleter!.future;

  final completer = Completer<bool>();
  _loaderCompleter = completer;

  void complete(bool value) {
    if (!completer.isCompleted) {
      completer.complete(value);
    }
    _loaderCompleter = null;
  }

  final existing = html.document.getElementById('google-maps-js');
  if (existing is html.ScriptElement) {
    existing.onLoad.first.then((_) => complete(_hasGoogleMaps()));
    existing.onError.first.then((_) => complete(false));
  } else {
    final script = html.ScriptElement()
      ..id = 'google-maps-js'
      ..src =
          'https://maps.googleapis.com/maps/api/js?key=$apiKey&libraries=geometry,marker&loading=async'
      ..async = true
      ..defer = true;

    script.onLoad.first.then((_) => complete(_hasGoogleMaps()));
    script.onError.first.then((_) => complete(false));
    html.document.head?.append(script);
  }

  Future<void>.delayed(const Duration(seconds: 12), () {
    if (!completer.isCompleted) complete(_hasGoogleMaps());
  });

  return completer.future;
}

bool get isGoogleMapsWebLoaded => _hasGoogleMaps();

bool _hasGoogleMaps() {
  if (!js.context.hasProperty('google')) return false;
  final google = js.context['google'];
  if (google == null) return false;
  return google is js.JsObject && google.hasProperty('maps');
}
