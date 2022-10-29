import 'package:core/core/commons/utils/logger/i_logger.dart';
import 'package:core/network/http_response.dart';
import 'package:dio/dio.dart';

abstract class INetworkClient {
  void addLoggingInterceptor(ILogger logger);

  Future<HttpResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  });

  Future<HttpResponse<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic> queryParameters,
    Options? options,
  });

  Future<HttpResponse<T>> getUri<T>(String url);
}
