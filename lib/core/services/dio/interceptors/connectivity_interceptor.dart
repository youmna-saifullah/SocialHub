import 'package:dio/dio.dart';

import '../../network/network_info.dart';

/// Interceptor for handling network connectivity
class ConnectivityInterceptor extends Interceptor {
  final NetworkInfo _networkInfo;

  ConnectivityInterceptor({required NetworkInfo networkInfo})
      : _networkInfo = networkInfo;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final isConnected = await _networkInfo.isConnected;
    
    if (!isConnected) {
      handler.reject(
        DioException(
          requestOptions: options,
          type: DioExceptionType.connectionError,
          error: 'No internet connection',
        ),
      );
      return;
    }
    
    super.onRequest(options, handler);
  }
}
