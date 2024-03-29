import 'package:core/core/commons/error/exceptions.dart';
import 'package:core/core/commons/utils/device/device_info_utils.dart';
import 'package:core/core/commons/utils/logger/i_logger.dart';
import 'package:core/network/http_response.dart';
import 'package:core/network/i_network_client.dart';
import 'package:core/network/options.dart';
import 'package:dio/dio.dart';

class DioNetworkClient implements INetworkClient {
  final Dio _dio;
  final IDeviceInfoUtils? deviceInfoUtils;

  static const int connectionTimeout =
      30 * 1000; //30 seconds, default is never timeout

  DioNetworkClient(BaseNetworkOptions networkOptions, {this.deviceInfoUtils})
      : _dio = Dio(BaseOptions(
          baseUrl: networkOptions.baseUrl,
          headers: networkOptions.headers,
          connectTimeout: connectionTimeout,
          receiveTimeout: connectionTimeout,
        ));

  @override
  void addLoggingInterceptor(ILogger logger) {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (option, handler) async {
        logger.d(
            'req path : ${option.uri.toString()}\nHeader : ${option.headers}\nQueryParam : ${option.queryParameters}\nData: ${option.data}');
        return handler.next(option);
      },
      onResponse: (response, handler) async {
        logger.d('Response of ${response.realUri}');
        logger.d(response.data);
        return handler.next(response);
      },
      onError: (error, handler) async {
        logger.e(
            '${error.requestOptions.baseUrl}${error.requestOptions.path}\n$error');
        return handler.next(error);
      },
    ));
  }

  @override
  Future<HttpResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _dio
        .get<T>(path, queryParameters: queryParameters, options: options)
        .then((Response<T> res) {
      _throwIfNoSuccess(res);
      var response = HttpResponse<T>(
          data: res.data,
          headers: res.headers.map,
          statusCode: res.statusCode ?? 0,
          statusMessage: res.statusMessage ?? '');
      return response;
    });
  }

  @override
  Future<HttpResponse<T>> post<T>(String path,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      String? contentType}) {
    return _dio
        .post<T>(path,
            data: data, queryParameters: queryParameters, options: options)
        .then((Response<T> res) {
      _throwIfNoSuccess(res);
      var response = HttpResponse<T>(
        data: res.data,
        headers: res.headers.map,
        statusCode: res.statusCode,
        statusMessage: res.statusMessage,
      );
      return response;
    });
  }

  @override
  Future<HttpResponse<T>> put<T>(String path,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      String? contentType}) {
    return _dio
        .put<T>(path,
            data: data, queryParameters: queryParameters, options: options)
        .then((Response<T> res) {
      _throwIfNoSuccess(res);
      var response = HttpResponse<T>(
        data: res.data,
        headers: res.headers.map,
        statusCode: res.statusCode,
        statusMessage: res.statusMessage,
      );
      return response;
    });
  }

  @override
  Future<HttpResponse<T>> delete<T>(String path,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      String? contentType}) {
    return _dio
        .delete<T>(path,
            data: data, queryParameters: queryParameters, options: options)
        .then((Response<T> res) {
      _throwIfNoSuccess(res);
      var response = HttpResponse<T>(
        data: res.data,
        headers: res.headers.map,
        statusCode: res.statusCode,
        statusMessage: res.statusMessage,
      );
      return response;
    });
  }

  @override
  Future<HttpResponse<T>> getUri<T>(String url) {
    return _dio.getUri<T>(Uri.parse(url)).then((Response<T> res) {
      _throwIfNoSuccess(res);
      var response = HttpResponse<T>(
          data: res.data,
          headers: res.headers.map,
          statusCode: res.statusCode,
          statusMessage: res.statusMessage);
      return response;
    });
  }

  void _throwIfNoSuccess(Response res) {
    if (res.data == null) {
      throw HttpException.serverException(res.statusMessage ?? '', res);
    }

    if (res.statusCode != null &&
        (res.statusCode! < 200 || res.statusCode! > 299) &&
        res.statusCode != 304) {
      var response = HttpResponse<dynamic>(
          data: res.data,
          headers: res.headers.map,
          statusCode: res.statusCode,
          statusMessage: res.statusMessage);
      throw HttpException.serverException(res.statusMessage ?? '', response);
    }
  }
}
