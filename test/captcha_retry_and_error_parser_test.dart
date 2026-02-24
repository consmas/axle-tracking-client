import 'package:axle_tracking_cms/core/network/api_error_parser.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('error parser maps cms_unauthorized', () {
    final exception = DioException(
      requestOptions: RequestOptions(path: '/api/v1/vehicles'),
      response: Response(
        requestOptions: RequestOptions(path: '/api/v1/vehicles'),
        statusCode: 422,
        data: {
          'error': {
            'code': 'cms_unauthorized',
            'message': 'CMS session expired',
          },
        },
      ),
      type: DioExceptionType.badResponse,
    );

    final parsed = ApiErrorParser.fromDioException(exception);
    expect(parsed.code, 'cms_unauthorized');
    expect(parsed.isCmsUnauthorized, isTrue);
  });

  test('error parser maps invalid_range', () {
    final exception = DioException(
      requestOptions: RequestOptions(path: '/api/v1/alarms'),
      response: Response(
        requestOptions: RequestOptions(path: '/api/v1/alarms'),
        statusCode: 422,
        data: {
          'error': {
            'code': 'invalid_range',
            'message': 'Invalid range',
          },
        },
      ),
      type: DioExceptionType.badResponse,
    );

    final parsed = ApiErrorParser.fromDioException(exception);
    expect(parsed.isInvalidRange, isTrue);
    expect(parsed.userMessage, 'Please choose a valid date range.');
  });

  test('error parser maps unauthorized on 401', () {
    final exception = DioException(
      requestOptions: RequestOptions(path: '/api/v1/vehicles'),
      response: Response(
        requestOptions: RequestOptions(path: '/api/v1/vehicles'),
        statusCode: 401,
      ),
      type: DioExceptionType.badResponse,
    );

    final parsed = ApiErrorParser.fromDioException(exception);
    expect(parsed.code, 'unauthorized');
    expect(parsed.statusCode, 401);
  });
}
