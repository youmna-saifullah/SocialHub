import 'package:dio/dio.dart';

import '../../config/app_config.dart';
import '../local_storage/local_storage_service.dart';
import '../logger/logger_service.dart';
import '../network/network_info.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/connectivity_interceptor.dart';
import 'interceptors/logging_interceptor.dart';

// =============================================================================
// Task 6.1 Step 1: Using Dio as advanced alternative to http package
// Task 6.1 Step 6: Use http.get(Uri.parse(url)) - Dio equivalent: dio.get()
// Task 6.2 Step 3: Use http.post() with headers and body - Dio equivalent
// Task 6.2 Step 5: Implement updatePost() with http.put() - Dio equivalent
// Task 6.2 Step 6: Create deletePost() with http.delete() - Dio equivalent
// =============================================================================

/// Configured Dio client for API requests
class DioClient {
  late final Dio dio;
  final LoggerService _logger;
  final LocalStorageService _localStorage;
  final NetworkInfo _networkInfo;

  DioClient({
    required LoggerService logger,
    required LocalStorageService localStorage,
    required NetworkInfo networkInfo,
  })  : _logger = logger,
        _localStorage = localStorage,
        _networkInfo = networkInfo {
    dio = _createDio();
    _addInterceptors();
  }

  Dio _createDio() {
    return Dio(
      BaseOptions(
        baseUrl: AppConfig.baseUrl,
        connectTimeout: AppConfig.connectionTimeout,
        receiveTimeout: AppConfig.receiveTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
  }

  void _addInterceptors() {
    dio.interceptors.addAll([
      ConnectivityInterceptor(networkInfo: _networkInfo),
      AuthInterceptor(localStorage: _localStorage),
      LoggingInterceptor(logger: _logger),
    ]);
  }

  // Task 6.1 Step 6: Use http.get(Uri.parse(url)) - Dio equivalent
  /// GET request
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  // Task 6.2 Step 3: Use http.post() with headers and body - Dio equivalent
  // Task 6.2 Step 4: Add jsonEncode() for request body - Dio handles serialization
  /// POST request
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    return dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  // Task 6.2 Step 5: Implement updatePost() with http.put() - Dio equivalent
  /// PUT request
  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return dio.put<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  /// PATCH request
  Future<Response<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return dio.patch<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  // Task 6.2 Step 6: Create deletePost() with http.delete() - Dio equivalent
  /// DELETE request
  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return dio.delete<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }

  // Task 6.4 Step 4-7: Multipart upload with progress for image upload
  /// Multipart upload with progress
  Future<Response<T>> uploadFile<T>(
    String path, {
    required FormData formData,
    void Function(int, int)? onSendProgress,
    CancelToken? cancelToken,
  }) async {
    return dio.post<T>(
      path,
      data: formData,
      options: Options(
        contentType: 'multipart/form-data',
      ),
      onSendProgress: onSendProgress,
      cancelToken: cancelToken,
    );
  }
}
