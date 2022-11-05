import 'dart:convert';

import 'package:core/core/commons/app_env.dart';
import 'package:core/core/commons/error/api_exception_handler.dart';
import 'package:core/core/commons/utils/share_preferences/share_preferences_helper.dart';
import 'package:core/core/model/document.dart';
import 'package:core/network/http_response.dart';
import 'package:core/network/i_network_client.dart';
import 'package:dio/dio.dart';

abstract class DocumentApiProvider {
  Future<DocumentFile> addDocument(DocumentFile deviceInfo);
  Future<DocumentFile> getDocumentByid(String id);
  Future<List<DocumentFile>> getDocumentList();
  Future<DocumentFile> updateDocument(String id, Map<String, dynamic> json);
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
          '${appEnv.apiBaseUrl}/api/documents',
          data: documentFile.toJson()..remove('id'),
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

  @override
  Future<DocumentFile> getDocumentByid(String id) async {
    try {
      final token = await getRefreshToken();
      final HttpResponse<dynamic> res = await client.get<dynamic>(
          '${appEnv.apiBaseUrl}/api/documents/$id',
          options: Options(headers: {'Authorization': "Bearer $token"}));
      final map = jsonDecode(res.data!) as Map<String, dynamic>;

      final response = DocumentFile.fromJson(map);
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
  Future<List<DocumentFile>> getDocumentList() async {
    try {
      final token = await getRefreshToken();
      final HttpResponse<dynamic> res = await client.get<dynamic>(
          '${appEnv.apiBaseUrl}/api/documents',
          options: Options(headers: {'Authorization': "Bearer $token"}));
      final data = List<Map<String, dynamic>>.from(res.data?["data"] ?? []);

      return data.map((e) => DocumentFile.fromJson(e)).toList();
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
  Future<DocumentFile> updateDocument(
      String id, Map<String, dynamic> json) async {
    try {
      final token = await getRefreshToken();
      final HttpResponse<dynamic> res =
          await client.put<dynamic>('${appEnv.apiBaseUrl}/api/documents/$id',
              data: json,
              options: Options(
                headers: {'Authorization': "Bearer $token"},
              ));
      final map = res.data! as Map<String, dynamic>;

      final response = DocumentFile.fromJson(map);
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
