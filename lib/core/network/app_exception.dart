class AppException implements Exception {
  AppException({
    required this.code,
    required this.message,
    this.statusCode,
  });

  final String code;
  final String message;
  final int? statusCode;

  bool get isUnauthorized => statusCode == 401 || code == 'unauthorized';
  bool get isCmsUnauthorized => code == 'cms_unauthorized';
  bool get isInvalidRange => code == 'invalid_range';

  String get userMessage {
    switch (code) {
      case 'cms_invalid_credentials':
        return 'CMS credentials are invalid. Please contact support.';
      case 'cms_error':
      case 'cms_server_error':
      case 'cms_timeout':
        return 'CMS service is temporarily unavailable. Please try again.';
      case 'invalid_range':
        return 'Please choose a valid date range.';
      default:
        return message;
    }
  }

  @override
  String toString() => 'AppException(code: $code, message: $message)';
}
