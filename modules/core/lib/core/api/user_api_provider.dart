import 'package:core/core/commons/app_env.dart';
import 'package:core/core/commons/error/api_exception_handler.dart';
import 'package:core/core/model/device_info.dart';
import 'package:core/network/http_response.dart';
import 'package:core/network/i_network_client.dart';
import 'package:dio/dio.dart';

abstract class UserApiProvider {
  Future<DeviceInfo> submitDeviceInfo(DeviceInfo deviceInfo);
  Future<String> login(String deviceId);
}

class UserApiProviderImpl
    with ApiClientExceptionHandler
    implements UserApiProvider {
  final INetworkClient client;
  final AppEnv appEnv;
  UserApiProviderImpl({
    required this.client,
    required this.appEnv,
  });
  @override
  Future<DeviceInfo> submitDeviceInfo(DeviceInfo deviceInfo) async {
    try {
      final HttpResponse<dynamic> res = await client.post<dynamic>(
          '${appEnv.apiBaseUrl}/devices',
          data: deviceInfo.toJson());
      final response = DeviceInfo.fromJson((res.data! as Map<String, dynamic>));
      return response;
    } on DioError catch (exception) {
      throw apiExceptionHandler(exception);
    } on Error catch (error) {
      throw apiExceptionHandler(Exception(error.toString()), error: error);
    } catch (e) {
      throw apiExceptionHandler(e is Exception ? e : Exception(e.toString()),
          error: Error());
    }
  }

  @override
  Future<String> login(String deviceId) async {
    try {
      final HttpResponse<dynamic> res = await client.post<dynamic>(
          '${appEnv.apiBaseUrl}/auth',
          queryParameters: {"device_id": deviceId});
      final token = res.data!["token"] as String;
      return token;
    } on DioError catch (exception) {
      throw apiExceptionHandler(exception);
    } on Error catch (error) {
      throw apiExceptionHandler(Exception(error.toString()), error: error);
    } catch (e) {
      throw apiExceptionHandler(e is Exception ? e : Exception(e.toString()),
          error: Error());
    }
  }
}
