import 'package:core/core/model/document.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:documenteditor/app/path/app_path.dart' as app_path;
import 'package:documenteditor/presentation/bloc/editor/editor_bloc.dart';
import 'package:documenteditor/presentation/widget/document_list/document_list_page.dart';
import 'package:documenteditor/presentation/widget/editor/editor_page.dart';

GoRouter getRouter() => GoRouter(routes: [
      GoRoute(
          path: app_path.home,
          builder: (context, state) => const DocumentListPage()),
      GoRoute(
          path: app_path.editorPage,
          builder: (context, state) => BlocProvider<DocumentEditorBloc>(
                create: (context) => DocumentEditorBloc(),
                child: EditorPage(
                  document: state.extra as DocumentFile?,
                ),
              ))
    ]);
