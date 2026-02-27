import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../../logger/logger_service.dart';

/// Interceptor for logging all HTTP requests and responses
class LoggingInterceptor extends Interceptor {
  final LoggerService _logger;

  LoggingInterceptor({required LoggerService logger}) : _logger = logger;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger.log(
      Level.info,
      '🌐 REQUEST[${options.method}] => PATH: ${options.path}',
    );
    _logger.log(Level.debug, 'Headers: ${options.headers}');
    if (options.data != null) {
      _logger.log(Level.debug, 'Data: ${options.data}');
    }
    if (options.queryParameters.isNotEmpty) {
      _logger.log(Level.debug, 'Query: ${options.queryParameters}');
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger.log(
      Level.info,
      '✅ RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
    );
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.log(
      Level.error,
      '❌ ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
    );
    _logger.log(Level.error, 'Message: ${err.message}');
    super.onError(err, handler);
  }
}
