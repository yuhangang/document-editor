import 'package:core/core/model/document.dart';
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
  final GlobalKey<AnimatedListState> _animatedListState = GlobalKey();
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
      body: BlocConsumer<DocumentListBloc, DocumentListState>(
        listener: ((context, state) {
          if (state is DocumentListDeleted) {
            // TODO: implement animated list UI
            //  _handleDeleteAnimation(_animatedListState, state.deleteDocuments,state.onDeleteAnimationDone, state.documents);
            state.onDeleteAnimationDone();
          }
        }),
        listenWhen: (p, c) => c is DocumentListDeleted,
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
                      onRefresh: () async {
                        _documentListCubit.add(OnDocumentListLoad());
                      },
                      child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        key: _animatedListState,
                        padding: const EdgeInsets.only(
                            top: 25, left: 16, right: 16, bottom: 35),
                        itemCount: state.documents.length,
                        itemBuilder: (context, index) {
                          final document = state.documents[index];
                          return Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    index < state.documents.length - 1 ? 8 : 0),
                            child: DocumentItem(
                                title: document.title,
                                timeStamp: getUpdateTimeDescription(
                                    state.loadedAt, document.updatedAt),
                                onTap: () {
                                  GoRouter.of(context).push(app_path.editorPage,
                                      extra: document);
                                },
                                // onClone: () {
                                //   _documentListCubit.add(OnDocumentListAdd(
                                //       documents: [document.clone()]));
                                // },
                                onDelete: () {
                                  _documentListCubit.add(
                                      OnDocumentListDelete(document: document));
                                }),
                          );
                        },
                      )),
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

  // ignore: unused_element
  void _handleDeleteAnimation(
      GlobalKey<AnimatedListState> animatedListKey,
      List<DocumentFile> deletedDocuments,
      VoidCallback animationCompleteCallback,
      List<DocumentFile> messages) {
    const Duration animationDuration = Duration(milliseconds: 500);
    for (final message in deletedDocuments) {
      final indexOfMsgToBeRemoved =
          messages.indexWhere((soc) => soc == message);
      if (indexOfMsgToBeRemoved != -1) {
        final data = messages.removeAt(indexOfMsgToBeRemoved);
        _appliedRemovalAnimation(
            animatedListKey, indexOfMsgToBeRemoved, data, animationDuration);
      }
    }
    Future.delayed(animationDuration, animationCompleteCallback);
  }

  void _appliedRemovalAnimation(GlobalKey<AnimatedListState> messageListKey,
      int index, DocumentFile documentFile, Duration animationDuration) {
    return messageListKey.currentState!.removeItem(index, (context, animation) {
      final curvedAnimation = animation.drive(Tween<double>(begin: 0, end: 1)
          .chain(CurveTween(curve: Curves.easeInCubic)));
      return SizeTransition(
        sizeFactor: curvedAnimation,
        child: FadeTransition(
          opacity: curvedAnimation,
          child: DocumentItem(
            title: documentFile.title,
            timeStamp: getUpdateTimeDescription(
                DateTime.now(), documentFile.updatedAt),
            onDelete: () {},
            onTap: () {},
          ),
        ),
      );
    }, duration: animationDuration);
  }

  String getUpdateTimeDescription(DateTime timeToCompare, DateTime time) {
    final difference = timeToCompare.difference(time);
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
