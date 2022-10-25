import 'package:core/core/model/document.dart';
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
                          return GestureDetector(
                            onTap: () {
                              GoRouter.of(context)
                                  .push(app_path.editorPage, extra: document);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                color: Colors.grey[50],
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          document.title,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6,
                                        ),
                                        Text(getUpdateTimeDescription(
                                            state.loadedAt, document))
                                      ],
                                    ),
                                  ),
                                  PopupMenuButton<String>(
                                    onSelected: (value) {
                                      if (value ==
                                          DocumentMenuItemAction.delete.name) {
                                        _documentListCubit.add(
                                            OnDocumentListDelete(
                                                documents: [document]));
                                      } else if (value ==
                                          DocumentMenuItemAction.clone.name) {
                                        _documentListCubit.add(
                                            OnDocumentListAdd(
                                                documents: [document.clone()]));
                                      }
                                    },
                                    padding: EdgeInsets.zero,
                                    itemBuilder: (BuildContext context) {
                                      return DocumentMenuItemAction.values
                                          .map((e) => e.name)
                                          .map((String choice) {
                                        return PopupMenuItem<String>(
                                          value: choice,
                                          child: Text(choice),
                                        );
                                      }).toList();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 10,
                          );
                        }),
                  ),
                ),
              ],
            );
          }

          return const Center(
              child: Text("You currently didn't have any document."));
        },
      ),
    );
  }

  String getUpdateTimeDescription(
      DateTime timeToCompare, DocumentFile document) {
    final difference = timeToCompare.difference(document.updatedAt);
    if (difference.inDays > 364) {
      return "${(difference.inDays / 365).floor()} years ago";
    } else if (difference.inDays > 27) {
      return "${(difference.inDays / 28).floor()} months ago";
    } else if (difference.inDays > 6) {
      return "${(difference.inDays / 7).floor()} weeks ago";
    } else if (difference.inDays > 0) {
      return "${difference.inDays} days ago";
    } else if (difference.inHours > 0) {
      return "${difference.inHours} hours ago";
    } else if (difference.inMinutes > 1) {
      return "${difference.inMinutes} minutes ago";
    }
    return "just now";
  }
}

enum DocumentMenuItemAction { delete, clone }
