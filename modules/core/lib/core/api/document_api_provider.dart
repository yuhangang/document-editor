import 'package:core/core/commons/app_env.dart';
import 'package:core/core/commons/error/api_exception_handler.dart';
import 'package:core/core/commons/utils/share_preferences/share_preferences_helper.dart';
import 'package:core/core/model/document.dart';
import 'package:core/network/http_response.dart';
import 'package:core/network/i_network_client.dart';
import 'package:dio/dio.dart';

abstract class DocumentApiProvider {
  Future<DocumentFile> addDocument(DocumentFile deviceInfo);
}

class DocumentApiProviderImpl
    with ApiClientExceptionHandler, SharePreferencesHelper
    implements DocumentApiProvider {
  final INetworkClient client;
  final AppEnv appEnv;
  DocumentApiProviderImpl({
    required this.client,
    required this.appEnv,
  });
  @override
  Future<DocumentFile> addDocument(DocumentFile documentFile) async {
    try {
      final token = await getRefreshToken();
      final HttpResponse<dynamic> res = await client.post<dynamic>(
          '${appEnv.apiBaseUrl}/api/devices',
          data: documentFile.toJson(),
          options: Options(headers: {'Authorization': "Bearer $token"}));
      final response =
          DocumentFile.fromJson((res.data! as Map<String, dynamic>));
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
}
