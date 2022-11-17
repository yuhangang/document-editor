import 'dart:io';

import 'package:core/core/commons/app_env.dart';
import 'package:core/core/commons/error/api_exception_handler.dart';
import 'package:core/core/commons/error/exceptions.dart';
import 'package:core/core/commons/utils/share_preferences/share_preferences_helper.dart';
import 'package:core/network/http_response.dart';
import 'package:core/network/i_network_client.dart';
import 'package:dio/dio.dart';

abstract class AttachmentApiProvider {
  Future<String> addAttachment(File file);
  Future<void> deleteAttachmnt(String id);
}

class AttachmentApiProviderImpl
    with ApiClientExceptionHandler, SharePreferencesHelper
    implements AttachmentApiProvider {
  final INetworkClient client;
  final AppEnv appEnv;
  AttachmentApiProviderImpl({
    required this.client,
    required this.appEnv,
  });

  @override
  Future<String> addAttachment(File file) async {
    try {
      FormData formData =
          FormData.fromMap({"files": await MultipartFile.fromFile(file.path)});
      final token = await getRefreshToken();
      final HttpResponse<dynamic> res = await client.post<dynamic>(
          '${appEnv.apiBaseUrl}/api/attachments',
          data: formData,
          options: Options(headers: {'Authorization': "Bearer $token"}));
      final attachments =
          "${appEnv.apiBaseUrl}/attachments/uploads/${(res.data! as String)}";
      return attachments;
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
  Future<void> deleteAttachmnt(String id) async {
    try {
      final token = await getRefreshToken();
      final HttpResponse<dynamic> res = await client.delete<dynamic>(
          '${appEnv.apiBaseUrl}/api/attachments/$id',
          options: Options(headers: {'Authorization': "Bearer $token"}));

      if (res.statusCode == 200) return;
      throw UnknownException();
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
