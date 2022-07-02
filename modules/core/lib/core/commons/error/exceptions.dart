
import 'package:core/network/exception/api_exception.dart';
import 'package:equatable/equatable.dart';

class BaseException extends Equatable implements Exception {
  @override
  List<Object?> get props => [];
}

class NetworkException extends BaseException {
  @override
  String toString() {
    return 'Check your network';
  }
}

class ServerException extends BaseException {
  final dynamic _error;
  ServerException(this._error);

  @override
  String toString() {
    return _error.toString();
  }

  @override
  List<Object?> get props => [_error];
}

class ApiDowntimeException extends BaseException {
  final dynamic response;

  ApiDowntimeException(this.response);

  @override
  List<Object> get props => [response];
}

class CacheException extends BaseException {}

class UnknownException extends BaseException {}

class UnauthorizedException extends BaseException {
  final dynamic response;

  UnauthorizedException(this.response);

  @override
  List<Object> get props => [response];
}

class HttpException extends BaseException {
  final dynamic response;
  final String? errorMsg;
  final int? errorCode;
  final ApiException? apiException;

  HttpException.apiException(
      {required this.apiException,
      this.response,
      this.errorCode,
      this.errorMsg});

  HttpException.serverException(this.errorMsg, this.response,
      {this.errorCode, this.apiException});

  HttpException(
      {this.response, this.errorCode, this.errorMsg, this.apiException});

  @override
  String toString() {
    return errorMsg ?? response.toString();
  }

  @override
  List<Object?> get props => [response, errorMsg, errorCode, apiException];
}

class UserDataNotFoundException extends BaseException {}

class ParsingException extends BaseException {}

class EmptyUserOrProductException extends BaseException {}

class BroadbandUnsupportedAddressException extends BaseException {}

class ExpiredLeadTokenException extends BaseException {
  final dynamic response;

  ExpiredLeadTokenException(this.response);

  @override
  List<Object> get props => [response];
}

class ThirdPartyApiException extends BaseException {
  final dynamic response;

  ThirdPartyApiException(this.response);

  @override
  List<Object> get props => [response];
}

class FetchLocalUserDataException extends BaseException {}

class InvalidBroadbandEligibleType extends BaseException {}

class InvalidMeshQuantityException extends BaseException {
  @override
  String toString() {
    return 'Please check mesh quantity. It should atleast 1.';
  }
}

class LeadTokenMissingException extends BaseException {
  @override
  String toString() {
    return 'Lead token not found.';
  }
}

class InvalidUserRequestException extends BaseException {}
