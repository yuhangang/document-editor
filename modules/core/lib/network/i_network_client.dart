import 'package:core/core/commons/utils/logger/i_logger.dart';
import 'package:core/network/http_response.dart';

abstract class INetworkClient{
  void addLoggingInterceptor(ILogger logger);

  Future<HttpResponse<T>> get<T>(String path,
      {Map<String, dynamic>? queryParameters,
});

  Future<HttpResponse<T>> getUri<T>(String url);
}