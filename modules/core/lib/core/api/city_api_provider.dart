

import 'package:core/core/api/i_city_api_provider.dart';
import 'package:core/core/commons/app_env.dart';
import 'package:core/core/commons/error/api_exception_handler.dart';
import 'package:core/core/model/city.dart';
import 'package:core/network/http_response.dart';
import 'package:core/network/i_network_client.dart';
import 'package:dio/dio.dart';

class CityApiProvider
    with ApiClientExceptionHandler
    implements ICityApiProvider {
  final INetworkClient client;
  final AppEnv appEnv;
  CityApiProvider({
    required this.client,
    required this.appEnv,
  });
  @override
  Future<List<MalaysianCity>> getMalaysianCityList() async {
    try {
      final HttpResponse<List<dynamic>> res =
          await client.get<List<dynamic>>(appEnv.cityListJsonApiRoute);

      final response = (res.data!)
          .map((json) => MalaysianCity.fromJson(json))
          .toList();
      return response;
    } on DioError catch (exception) {
      throw apiExceptionHandler(exception);
    } on Error catch (error) {
      throw apiExceptionHandler(Exception(error.toString()), error: error);
    } catch (e){
       throw apiExceptionHandler(Exception(''), error: Error());
    }
  }
}
