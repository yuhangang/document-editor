/// The common config for the Dio instance.
/// `dio.options` is a instance of [BaseNetworkOptions]
class BaseNetworkOptions extends _NetworkRequestConfig {
  BaseNetworkOptions({
    String? method,
    this.connectTimeout,
    int? receiveTimeout,
    int? sendTimeout,
    required this.baseUrl,
    this.queryParameters,
    Map<String, dynamic>? extra,
    Map<String, dynamic>? headers,
    String? contentType,
  }) : super(
          method: method,
          receiveTimeout: receiveTimeout,
          sendTimeout: sendTimeout,
          extra: extra,
          headers: headers,
          contentType: contentType,
        );

  /// Request base url, it can contain sub path, like: "https://www.google.com/api/".
  String baseUrl;

  /// Common query parameters
  Map<String, dynamic>? queryParameters;

  /// Timeout in milliseconds for opening url.
  /// [Dio] will throw the [DioError] with [DioErrorType.CONNECT_TIMEOUT] type
  ///  when time out.
  int? connectTimeout;
}

/// Every request can pass an [Options] object which will be merged with [Dio.options]
class NetworkOptions extends _NetworkRequestConfig {
  NetworkOptions({
    String? method,
    int? sendTimeout,
    int? receiveTimeout,
    Map<String, dynamic>? extra,
    Map<String, dynamic>? headers,
    String? contentType,
  }) : super(
          method: method,
          sendTimeout: sendTimeout,
          receiveTimeout: receiveTimeout,
          extra: extra,
          headers: headers,
          contentType: contentType ?? 'application/json',
        );
}

class NetworkRequestOptions extends NetworkOptions {
  NetworkRequestOptions({
    String? method,
    int? sendTimeout,
    int? receiveTimeout,
    this.connectTimeout,
    this.data,
    this.path,
    this.queryParameters,
    this.baseUrl,
    Map<String, dynamic>? extra,
    Map<String, dynamic>? headers,
    String? contentType,
  }) : super(
          method: method,
          sendTimeout: sendTimeout,
          receiveTimeout: receiveTimeout,
          extra: extra,
          headers: headers,
          contentType: contentType ?? 'application/json',
        );

  /// Request data, can be any type.
  dynamic data;

  /// Request base url, it can contain sub path, like: 'https://www.google.com/api/'.
  String? baseUrl;

  /// If the `path` starts with 'http(s)', the `baseURL` will be ignored, otherwise,
  /// it will be combined and then resolved with the baseUrl.
  String? path = '';

  /// See [Uri.queryParameters]
  Map<String, dynamic>? queryParameters;

  int? connectTimeout;
}

/// The [_NetworkRequestConfig] class describes the http request information and configuration.
class _NetworkRequestConfig {
  _NetworkRequestConfig(
      {this.method,
      this.receiveTimeout,
      this.sendTimeout,
      this.extra,
      this.headers,
      String? contentType}) {
    this.contentType = contentType;
  }

  /// Http method.
  String? method;

  /// Http request headers. The keys of initial headers will be converted to lowercase,
  /// for example 'Content-Type' will be converted to 'content-type'.
  ///
  /// You should use lowercase as the key name when you need to set the request header.
  Map<String, dynamic>? headers;

  /// Timeout in milliseconds for sending data.
  /// [Dio] will throw the [DioError] with [DioErrorType.SEND_TIMEOUT] type
  ///  when time out.
  int? sendTimeout;

  ///  Timeout in milliseconds for receiving data.
  ///  [Dio] will throw the [DioError] with [DioErrorType.RECEIVE_TIMEOUT] type
  ///  when time out.
  ///
  /// [0] meanings no timeout limit.
  int? receiveTimeout;

  /// Custom field that you can retrieve it later in [Interceptor]、[Transformer] and the [Response] object.
  Map<String, dynamic>? extra;

  /// The request Content-Type. The default value is [ContentType.json].
  /// If you want to encode request body with 'application/x-www-form-urlencoded',
  /// you can set `ContentType.parse('application/x-www-form-urlencoded')`, and [Dio]
  /// will automatically encode the request body.
  set contentType(String? contentType) {
    headers?['content-type'] = contentType?.trim();
  }

  String get contentType {
    dynamic ct = headers?['content-type'];
    return ct == null ? '' : (ct as String);
  }
}
