import 'dart:async';

import 'package:core/core/commons/app_env.dart';
import 'package:core/core/repository/document_repository.dart';
import 'package:core/core/repository/setting_repository.dart';
import 'package:documenteditor/presentation/bloc/document_list/document_list_bloc.dart';
import 'package:documenteditor/presentation/bloc/document_editor/document_editor_bloc.dart';
import 'package:documenteditor/presentation/bloc/session_bloc/session_bloc.dart';
import 'package:documenteditor/presentation/bloc/setting/setting_bloc.dart';
import 'package:get_it/get_it.dart';

Future<void> configureAppServiceLocator(GetIt sl, AppEnv env) async {
  sl.registerFactory<SettingBloc>(
      () => SettingBloc(sl.get<SettingRepository>()));

  sl.registerFactory<DocumentListBloc>(
      () => DocumentListBloc(sl.get<DocumentRepository>()));

  sl.registerFactory<SessionBloc>(
      () => SessionBloc(sl.get<SettingRepository>()));

  sl.registerFactoryParam<DocumentEditorBloc, DocumentListBloc, void>(
      (documentListBloc, _) =>
          DocumentEditorBloc(sl.get<DocumentRepository>(), documentListBloc));
}
