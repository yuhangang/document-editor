import 'dart:io';

import 'package:core/core/commons/error/exceptions.dart';
import 'package:core/core/commons/utils/logger/i_logger.dart';
import 'package:core/core/di/service_locator.dart';
import 'package:dio/dio.dart';

mixin ApiClientExceptionHandler {
  Exception apiExceptionHandler(Exception exception, {Error? error}) {
    if (exception is SocketException) {
      return ServerException(exception);
    } else if (exception is DioError) {
      return exception;
    } else {
      sl.get<ILogger>().e(error);
      if (error != null) {
        if (error is TypeError) {
          return ParsingException();
        }
      }
   
      return UnknownException();
    }
  }
}