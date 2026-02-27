import 'package:dio/dio.dart';

import '../../local_storage/local_storage_service.dart';

/// Interceptor for adding authentication headers to requests
class AuthInterceptor extends Interceptor {
  final LocalStorageService _localStorage;

  AuthInterceptor({required LocalStorageService localStorage})
      : _localStorage = localStorage;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = _localStorage.getAuthToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    
    // Add common headers
    options.headers['Content-Type'] = 'application/json';
    options.headers['Accept'] = 'application/json';
    
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Handle 401 Unauthorized - clear token and redirect to login
    if (err.response?.statusCode == 401) {
      _localStorage.clearAuthToken();
      // You could also trigger a logout event here
    }
    super.onError(err, handler);
  }
}
