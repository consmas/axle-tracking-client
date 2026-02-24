import 'package:axle_tracking_cms/core/config/env.dart';
import 'package:axle_tracking_cms/core/network/api_error_parser.dart';
import 'package:axle_tracking_cms/core/network/app_exception.dart';
import 'package:axle_tracking_cms/core/services/secure_storage_service.dart';
import 'package:axle_tracking_cms/core/services/session_invalidator.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiClient {
  ApiClient({
    required SecureStorageService storageService,
    required SessionInvalidator sessionInvalidator,
  })  : _storageService = storageService,
        _sessionInvalidator = sessionInvalidator,
        _dio = Dio(
          BaseOptions(
            baseUrl: EnvConfig.baseUrl,
            connectTimeout: const Duration(seconds: 15),
            receiveTimeout: const Duration(seconds: 20),
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
          ),
        ) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _storageService.readToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          if (kDebugMode) {
            debugPrint('[API] ${options.method} ${options.uri}');
          }
          handler.next(options);
        },
        onError: (error, handler) async {
          if (kDebugMode) {
            debugPrint('[API][ERR] ${error.requestOptions.method} '
                '${error.requestOptions.uri} -> ${error.response?.statusCode} '
                '${error.message}');
          }
          final parsed = ApiErrorParser.fromDioException(error);

          if (parsed.isUnauthorized) {
            _sessionInvalidator.invalidate();
            handler.reject(_toDioException(error, parsed));
            return;
          }

          final request = error.requestOptions;
          final alreadyRetried = request.extra[_cmsRetryKey] == true;
          final isCmsLogin = request.path == '/api/v1/cms/login';

          if (parsed.isCmsUnauthorized && !alreadyRetried && !isCmsLogin) {
            try {
              await refreshCmsSession();
              final retried = await _dio.fetch<dynamic>(
                request.copyWith(
                  extra: <String, dynamic>{
                    ...request.extra,
                    _cmsRetryKey: true,
                  },
                ),
              );
              handler.resolve(retried);
              return;
            } on DioException catch (_) {
              handler.reject(_toDioException(error, parsed));
              return;
            }
          }

          handler.reject(_toDioException(error, parsed));
        },
      ),
    );
  }

  static const _cmsRetryKey = 'cms_unauthorized_retried';

  final Dio _dio;
  final SecureStorageService _storageService;
  final SessionInvalidator _sessionInvalidator;

  Future<void> refreshCmsSession() async {
    await _dio.post<Map<String, dynamic>>('/api/v1/cms/login');
  }

  Future<void> initializeCmsSession() => refreshCmsSession();

  Future<Map<String, dynamic>> cmsLoginDiagnostic() async {
    final response =
        await _dio.post<Map<String, dynamic>>('/api/v1/cms/login_diagnostic');
    return response.data ?? <String, dynamic>{};
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Duration? connectTimeout,
    Duration? receiveTimeout,
  }) async {
    return _execute(
      () => _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: Options(
          connectTimeout: connectTimeout,
          receiveTimeout: receiveTimeout,
        ),
      ),
    );
  }

  Future<Response<T>> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Duration? connectTimeout,
    Duration? receiveTimeout,
  }) async {
    return _execute(
      () => _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          connectTimeout: connectTimeout,
          receiveTimeout: receiveTimeout,
        ),
      ),
    );
  }

  Future<Response<T>> _execute<T>(Future<Response<T>> Function() call) async {
    try {
      return await call();
    } on DioException catch (error) {
      final payload = error.error;
      if (payload is AppException) {
        throw payload;
      }
      throw ApiErrorParser.fromDioException(error);
    }
  }

  DioException _toDioException(DioException source, AppException appError) {
    return source.copyWith(
      error: appError,
      message: appError.message,
    );
  }
}
