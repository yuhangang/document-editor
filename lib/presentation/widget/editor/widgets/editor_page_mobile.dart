import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:documenteditor/presentation/bloc/editor/editor_bloc.dart';
import 'package:documenteditor/presentation/widget/editor/widgets/rich_text_toolbar.dart';

class EditorPageMobile extends StatelessWidget {
  const EditorPageMobile({
    Key? key,
    required QuillController richTextController,
    required FocusNode focusNode,
    required ScrollController scrollController,
    required this.showFullToolBar,
    required this.isMobileLayout,
    required Animation<double> animation,
    required this.onSaved,
    required this.onChangedTitle,
    required this.titleController,
  })  : _richTextController = richTextController,
        _focusNode = focusNode,
        _scrollController = scrollController,
        _animation = animation,
        super(key: key);

  final QuillController _richTextController;
  final FocusNode _focusNode;
  final ScrollController _scrollController;
  final ValueNotifier<bool> showFullToolBar;
  final bool isMobileLayout;
  final Animation<double> _animation;
  final VoidCallback onSaved;
  final void Function(String?) onChangedTitle;
  final TextEditingController titleController;

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
                      if (_richTextController.hasUndo) {
                        _richTextController.undo();
                      }
                    },
                    icon: const Icon(Icons.undo)),
                IconButton(
                    onPressed: () {
                      if (_richTextController.hasRedo) {
                        _richTextController.redo();
                      }
                    },
                    icon: const Icon(Icons.redo)),
              ],
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(30.0),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
                BlocBuilder<DocumentEditorBloc, DocumentEditorState>(
              builder: (context, state) {
                if (state is DocumentEditorChangeUnsaved) {
                  return FloatingActionButton(
                    onPressed: onSaved,
                    child: const Icon(Icons.save),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
            body: QuillEditor(
              autoFocus: true,
              expands: true,
              focusNode: _focusNode,
              controller: _richTextController,
              scrollController: _scrollController,
              scrollable: true,
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 100,
                  left: 16,
                  right: 16,
                  bottom: 50),
              readOnly: false, // true for view only mode
            ),
          ),
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
                      showFullToolBar: showFullToolBar,
                      richTextController: _richTextController),
                  IconButton(
                    onPressed: () {
                      showFullToolBar.value = !showFullToolBar.value;
                    },
                    icon: RotationTransition(
                        turns: _animation,
                        child: const Icon(Icons.arrow_downward)),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
