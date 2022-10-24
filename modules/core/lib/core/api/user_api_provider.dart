import 'package:core/core/commons/app_env.dart';
import 'package:core/core/commons/error/api_exception_handler.dart';
import 'package:core/core/model/device_info.dart';
import 'package:core/network/http_response.dart';
import 'package:core/network/i_network_client.dart';
import 'package:dio/dio.dart';

abstract class UserApiProvider {
  Future<DeviceInfo> submitDeviceInfo(DeviceInfo deviceInfo);
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
      final HttpResponse<List<dynamic>> res =
          await client.post<List<dynamic>>('http://192.168.0.2:1323/devices');

      final response = DeviceInfo.fromJson(res.data! as Map<String, dynamic>);
      return response;
    } on DioError catch (exception) {
      throw apiExceptionHandler(exception);
    } on Error catch (error) {
      throw apiExceptionHandler(Exception(error.toString()), error: error);
    } catch (e) {
      throw apiExceptionHandler(Exception(''), error: Error());
    }
  }
}
