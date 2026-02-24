class LiveStreamInfo {
  const LiveStreamInfo({
    required this.streamUrl,
    required this.rawStreamUrl,
    required this.protocol,
    required this.channel,
    required this.stream,
    required this.urls,
  });

  final String? streamUrl;
  final String? rawStreamUrl;
  final String? protocol;
  final String channel;
  final String stream;
  final List<String> urls;

  static LiveStreamInfo fromJson(
    Map<String, dynamic> json, {
    int channel = 0,
    int stream = 1,
  }) {
    final nested = json['live_stream'];
    final payload = nested is Map<String, dynamic> ? nested : json;

    final rawUrls = payload['urls'];
    final urls = rawUrls is List
        ? rawUrls
            .whereType<Object?>()
            .map((e) => e?.toString() ?? '')
            .where((e) => e.isNotEmpty)
            .toList(growable: false)
        : const <String>[];

    return LiveStreamInfo(
      streamUrl: _nullableString(payload['stream_url']),
      rawStreamUrl: _nullableString(payload['raw_stream_url']),
      protocol: _nullableString(payload['protocol']),
      channel: _nullableString(payload['channel']) ?? channel.toString(),
      stream: _nullableString(payload['stream']) ?? stream.toString(),
      urls: urls,
    );
  }
}

String? _nullableString(Object? value) {
  final text = value?.toString();
  if (text == null || text.isEmpty) return null;
  return text;
}
