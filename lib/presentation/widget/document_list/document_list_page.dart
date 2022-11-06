import 'package:documenteditor/presentation/bloc/setting/setting_bloc.dart';
import 'package:documenteditor/presentation/widget/document_list/widgets/document_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:documenteditor/presentation/bloc/document_list/document_list_bloc.dart';
import 'package:documenteditor/app/path/app_path.dart' as app_path;

class DocumentListPage extends StatefulWidget {
  const DocumentListPage({Key? key}) : super(key: key);

  @override
  State<DocumentListPage> createState() => _DocumentListPageState();
}

class _DocumentListPageState extends State<DocumentListPage> {
  late final DocumentListBloc _documentListCubit;
  @override
  void initState() {
    BlocProvider.of<SettingBloc>(context).add(InitSettingEvent());
    _documentListCubit = BlocProvider.of<DocumentListBloc>(context);
    _documentListCubit.add(OnDocumentListLoad());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Your Documents")),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          GoRouter.of(context).push(app_path.editorPage);
        },
      ),
      body: BlocBuilder<DocumentListBloc, DocumentListState>(
        builder: (context, state) {
          if (state is DocumentListFailed) {
            return const Center(
                child: Text('Something went wrong, please try again later'));
          }

          if (state is DocumentListInitial || state is DocumentListLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is DocumentListLoaded && state.documents.isNotEmpty) {
            return Column(
              children: [
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async =>
                        _documentListCubit.add(OnDocumentListLoad()),
                    child: ListView.separated(
                        padding: const EdgeInsets.only(
                            top: 25, left: 16, right: 16, bottom: 35),
                        itemCount: state.documents.length,
                        itemBuilder: (context, index) {
                          final document = state.documents[index];
                          return DocumentItem(
                              context: context,
                              document: document,
                              state: state,
                              // onClone: () {
                              //   _documentListCubit.add(OnDocumentListAdd(
                              //       documents: [document.clone()]));
                              // },
                              onDelete: () {
                                _documentListCubit.add(
                                    OnDocumentListDelete(document: document));
                              });
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 8,
                            )),
                  ),
                ),
              ],
            );
          }

          return LayoutBuilder(builder: (context, constraints) {
            return RefreshIndicator(
              onRefresh: () async =>
                  _documentListCubit.add(OnDocumentListLoad()),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: const Center(
                      child: Text("You currently didn't have any document.")),
                ),
              ),
            );
          });
        },
      ),
    );
  }
}
