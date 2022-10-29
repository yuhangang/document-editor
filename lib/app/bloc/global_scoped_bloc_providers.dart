import 'package:core/core/di/service_locator.dart';
import 'package:documenteditor/presentation/bloc/session_bloc/session_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:documenteditor/presentation/bloc/document_list/document_list_bloc.dart';
import 'package:documenteditor/presentation/bloc/setting/setting_bloc.dart';

List<BlocProvider> getGlobalScopedBlocProvider() => [
      BlocProvider<SettingBloc>(
        create: (_) => sl.get<SettingBloc>(),
      ),
      BlocProvider<DocumentListBloc>(
        create: (_) => sl.get<DocumentListBloc>(),
      ),
      BlocProvider<SessionBloc>(
        create: (_) => sl.get<SessionBloc>(),
      )
    ];
