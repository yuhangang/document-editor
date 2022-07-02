import 'package:logger/logger.dart';

abstract class ILogger {
  void v(dynamic message, [dynamic error, StackTrace? stackTrace]);
  void d(dynamic message, [dynamic error, StackTrace? stackTrace]);
  void i(dynamic message, [dynamic error, StackTrace? stackTrace]);
  void w(dynamic message, [dynamic error, StackTrace? stackTrace]);
  void e(dynamic message, [dynamic error, StackTrace? stackTrace]);
  void wtf(dynamic message, [dynamic error, StackTrace? stackTrace]);
}



class AppLogger implements ILogger {
  final Logger _logger;

  AppLogger(this._logger);

  /// Log a message at level [Level.verbose].
  @override
  void v(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.v(message, error, stackTrace);
  }

  /// Log a message at level [Level.debug].
  @override
  void d(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.d(message, error, stackTrace);
  }

  /// Log a message at level [Level.info].
  @override
  void i(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.i(message, error, stackTrace);
  }

  /// Log a message at level [Level.warning].
  @override
  void w(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.w(message, error, stackTrace);
  }

  /// Log a message at level [Level.error].
  @override
  void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error, stackTrace);
  }

  /// Log a message at level [Level.wtf].
  @override
  void wtf(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.wtf(message, error, stackTrace);
  }
}
