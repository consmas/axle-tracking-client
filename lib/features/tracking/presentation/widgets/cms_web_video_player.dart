import 'package:flutter/widgets.dart';

import 'cms_web_video_player_stub.dart'
    if (dart.library.html) 'cms_web_video_player_web.dart' as impl;

Widget buildCmsWebVideoPlayer({required String url}) {
  return impl.buildCmsWebVideoPlayer(url: url);
}

Widget buildHlsWebVideoPlayer({required String url}) {
  return impl.buildHlsWebVideoPlayer(url: url);
}
