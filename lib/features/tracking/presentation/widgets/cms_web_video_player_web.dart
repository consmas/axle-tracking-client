// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use

import 'dart:html' as html;
import 'dart:js' as js;
import 'dart:ui_web' as ui_web;

import 'package:flutter/widgets.dart';

final Set<String> _registeredViewTypes = <String>{};

// ── CMS H5 iframe embed player ────────────────────────────────────────────────

Widget buildCmsWebVideoPlayer({required String url}) {
  final viewType = 'cms-web-player-${url.hashCode}';

  if (_registeredViewTypes.add(viewType)) {
    ui_web.platformViewRegistry.registerViewFactory(viewType, (int viewId) {
      final frame = html.IFrameElement()
        ..src = url
        ..style.border = '0'
        ..style.width = '100%'
        ..style.height = '100%'
        ..allow = 'autoplay; fullscreen';
      return frame;
    });
  }

  return HtmlElementView(viewType: viewType);
}

// ── hls.js video player ───────────────────────────────────────────────────────
// Plays HLS (.m3u8) streams in Chrome/Firefox/Edge via Media Source Extensions.
// Falls back to native src for Safari which supports HLS natively.

Widget buildHlsWebVideoPlayer({required String url}) {
  final viewType = 'hls-player-${url.hashCode}';

  if (_registeredViewTypes.add(viewType)) {
    ui_web.platformViewRegistry.registerViewFactory(viewType, (int viewId) {
      final video = html.VideoElement()
        ..style.width = '100%'
        ..style.height = '100%'
        ..style.objectFit = 'contain'
        ..style.backgroundColor = '#07090D'
        ..autoplay = true
        ..controls = false;

      final hlsConstructor = js.context['Hls'];

      if (hlsConstructor is js.JsFunction) {
        // Hls.isSupported() — checks for MSE API (Chrome, Firefox, Edge)
        final isSupported =
            (hlsConstructor as js.JsObject).callMethod('isSupported')
                    as bool? ??
                false;

        if (isSupported) {
          final config = js.JsObject.jsify(<String, dynamic>{
            'enableWorker': true,
            'lowLatencyMode': true,
            'backBufferLength': 30,
          });
          // new Hls(config)
          final hls = js.JsObject(hlsConstructor, [config]);
          hls.callMethod('loadSource', [url]);
          hls.callMethod('attachMedia', [video]);
          // autoplay=true on the <video> element handles playback once ready
        } else {
          // MSE not available — fall back to native (Safari)
          video.src = url;
          video.play();
        }
      } else {
        // hls.js not loaded yet — assign src directly (Safari native HLS)
        video.src = url;
        video.play();
      }

      return video;
    });
  }

  return HtmlElementView(viewType: viewType);
}
