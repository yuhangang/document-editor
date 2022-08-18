class ApiException {
  final int responseCode;
  final String responseMessage;
  final Response response;

  ApiException(
      {required this.responseCode,
      required this.responseMessage,
      required this.response});
}

class Response {
  final List<Errors> errors;

  Response({required this.errors});
}

class Errors {
  final String errorCode;
  final String errorTitle;
  final String errorDescription;
  final String errorDebugDescription;
  final ErrorAttributes? errorAttributes;

  Errors(
      {required this.errorCode,
      required this.errorTitle,
      required this.errorDescription,
      required this.errorDebugDescription,
      this.errorAttributes});
}

class ErrorAttributes {
  final String? integrationType;
  final String? reason;
  final bool? rollback;
  ErrorAttributes({
    this.integrationType,
    this.reason,
    this.rollback,
  });
}
