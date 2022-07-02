import 'dart:convert';

/// Response describes the http Response info.
class HttpResponse<T> {
  HttpResponse({
    required this.data,
    required this.headers,
    required this.statusCode,
    required this.statusMessage,
  });

  /// Response body. may have been transformed, please refer to [ResponseType].
  T? data;

  /// Response headers.
  Map<String, List<String>>? headers;

  /// Http status code.
  int? statusCode;

  /// Returns the reason phrase associated with the status code.
  /// The reason phrase must be set before the body is written
  /// to. Setting the reason phrase after writing to the body.
  String? statusMessage;

  /// We are more concerned about `data` field.
  @override
  String toString() {
    if (data is Map) {
      return json.encode(data);
    }
    return data.toString();
  }
}
