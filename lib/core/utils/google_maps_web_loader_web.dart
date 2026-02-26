// ignore_for_file: deprecated_member_use, avoid_web_libraries_in_flutter

import 'dart:async';
import 'dart:html' as html;
import 'dart:js' as js;

Completer<bool>? _loaderCompleter;
const _mapsCallbackName = '__axleGoogleMapsInit';

Future<bool> ensureGoogleMapsWebLoaded(String apiKey) async {
  if (_isGoogleMapsReady()) return true;
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
    if (_isGoogleMapsReady()) {
      complete(true);
    } else {
      existing.onLoad.first.then((_) => complete(_isGoogleMapsReady()));
    }
    existing.onError.first.then((_) => complete(false));
  } else {
    js.context[_mapsCallbackName] = js.JsFunction.withThis((_) {
      complete(_isGoogleMapsReady());
      js.context.deleteProperty(_mapsCallbackName);
    });

    final script = html.ScriptElement()
      ..id = 'google-maps-js'
      ..src =
          'https://maps.googleapis.com/maps/api/js?key=$apiKey&v=weekly&libraries=geometry,places,marker&loading=async&callback=$_mapsCallbackName'
      ..async = true
      ..defer = true;

    script.onLoad.first.then((_) {
      if (_isGoogleMapsReady()) {
        complete(true);
      }
    });
    script.onError.first.then((_) => complete(false));
    html.document.head?.append(script);
  }

  Future<void>.delayed(const Duration(seconds: 12), () {
    if (!completer.isCompleted) complete(_isGoogleMapsReady());
  });

  return completer.future;
}

bool get isGoogleMapsWebLoaded => _isGoogleMapsReady();

bool _isGoogleMapsReady() {
  if (!js.context.hasProperty('google')) return false;
  final google = js.context['google'];
  if (google == null) return false;
  if (google is! js.JsObject || !google.hasProperty('maps')) return false;

  final maps = google['maps'];
  if (maps is! js.JsObject) return false;
  if (!maps.hasProperty('Map')) return false;
  if (!maps.hasProperty('MapTypeId')) return false;

  final mapTypeId = maps['MapTypeId'];
  if (mapTypeId is! js.JsObject) return false;
  return mapTypeId.hasProperty('ROADMAP');
}
