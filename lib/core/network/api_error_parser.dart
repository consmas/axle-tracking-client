import 'package:axle_tracking_cms/core/network/app_exception.dart';
import 'package:dio/dio.dart';

class ApiErrorParser {
  static AppException fromDioException(DioException exception) {
    final response = exception.response;
    final data = response?.data;
    final statusCode = response?.statusCode;

    if (data is Map<String, dynamic>) {
      final errorObj = data['error'];
      if (errorObj is Map<String, dynamic>) {
        final code = (errorObj['code'] ?? 'unknown_error').toString();
        final message =
            (errorObj['message'] ?? 'Unexpected server error').toString();

        return AppException(
          code: code,
          message: message,
          statusCode: statusCode,
        );
      }
    }

    if (statusCode == 401) {
      return AppException(
        code: 'unauthorized',
        message: 'Session expired. Please login again.',
        statusCode: statusCode,
      );
    }

    return AppException(
      code: 'network_error',
      message: exception.message ?? 'Network error occurred',
      statusCode: statusCode,
    );
  }
}
