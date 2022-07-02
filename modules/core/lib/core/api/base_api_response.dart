class BaseResponse {}

///Base Response for JSONObject response type
class BaseObjectApiResponse<T> extends BaseResponse {
  final int responseCode;
  final String responseMessage;
  final T response;

  BaseObjectApiResponse(
      {required this.responseCode,
      required this.responseMessage,
      required this.response});

  factory BaseObjectApiResponse.fromJson(
      Map<String, dynamic> json, Function fromJson) {
    final resCode = json['responseCode'] as int;
    final resMsg = json['responseMessage'] as String;

    return BaseObjectApiResponse<T>(
        responseCode: resCode,
        responseMessage: resMsg,
        response: fromJson(json['response']));
  }
}