import 'package:documenteditor/presentation/widget/document_list/widgets/document_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;

import 'package:documenteditor/presentation/bloc/document_editor/document_editor_bloc.dart';
import 'package:documenteditor/presentation/widget/editor/widgets/my_quill_toolbar.dart';

abstract class EditorPageBody extends StatelessWidget {
  final QuillController richTextController;
  final FocusNode focusNode;
  final ScrollController scrollController;
  final ValueNotifier<bool> showFullToolBar;
  final bool isMobileLayout;
  final Animation<double> animation;
  final VoidCallback onSaved;
  final void Function(String?) onChangedTitle;
  final TextEditingController titleController;
  final Widget body;

  const EditorPageBody({
    Key? key,
    required this.richTextController,
    required this.focusNode,
    required this.scrollController,
    required this.showFullToolBar,
    required this.isMobileLayout,
    required this.animation,
    required this.onSaved,
    required this.onChangedTitle,
    required this.titleController,
    required this.body,
  }) : super(key: key);
}

class EditorPageMobile extends EditorPageBody {
  const EditorPageMobile(
      {super.key,
      required super.richTextController,
      required super.focusNode,
      required super.scrollController,
      required super.showFullToolBar,
      required super.isMobileLayout,
      required super.animation,
      required super.onSaved,
      required super.onChangedTitle,
      required super.titleController,
      required super.body});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                toolbarHeight: 55,
                backgroundColor: Colors.blueAccent.withOpacity(0.1),
                actions: [
                  IconButton(
                      onPressed: () {
                        if (richTextController.hasUndo) {
                          richTextController.undo();
                        }
                      },
                      icon: const Icon(Icons.undo)),
                  IconButton(
                      onPressed: () {
                        if (richTextController.hasRedo) {
                          richTextController.redo();
                        }
                      },
                      icon: const Icon(Icons.redo)),
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.more_vert),
                    onSelected: (value) {
                      if (value == DocumentMenuItemAction.delete.name) {
                        // onDelete.call();
                      } else if (value == DocumentMenuItemAction.clone.name) {
                        //onClone.call();
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
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(30.0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: TextField(
                      controller: titleController,
                      onChanged: onChangedTitle,
                      decoration: const InputDecoration.collapsed(
                          hintText: "Title of Document"),
                    ),
                  ),
                ),
              ),
              resizeToAvoidBottomInset: false,
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endDocked,
              floatingActionButton:
                  BlocSelector<DocumentEditorBloc, DocumentEditorState, bool>(
                selector: (state) => state is DocumentEditorChangeUnsaved,
                builder: (context, hasUnsavedChanges) {
                  if (hasUnsavedChanges) {
                    return FloatingActionButton(
                      onPressed: onSaved,
                      child: const Icon(Icons.save),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
              body: body),
        ),
        Material(
          child: Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SafeArea(
              top: false,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichTextToolbar.mobile(
                      focusNode: focusNode,
                      showFullToolBar: showFullToolBar,
                      richTextController: richTextController),
                  IconButton(
                    onPressed: () {
                      showFullToolBar.value = !showFullToolBar.value;
                    },
                    icon: RotationTransition(
                        turns: animation,
                        child: const Icon(Icons.arrow_downward)),
                  )
                ],
              ),
            ),
          ),
        ),
        BlocSelector<DocumentEditorBloc, DocumentEditorState, bool>(
            selector: (state) => state is DocumentEditorChangeSaving,
            builder: (context, isLoading) {
              if (isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return const SizedBox.shrink();
            })
      ],
    );
  }
}
