import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:weatherapp/presentation/widget/editor/widgets/rich_text_toolbar.dart';

class EditorPageMobile extends StatelessWidget {
  const EditorPageMobile({
    Key? key,
    required QuillController richTextController,
    required FocusNode focusNode,
    required ScrollController scrollController,
    required this.showFullToolBar,
    required this.isMobileLayout,
    required Animation<double> animation,
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(backgroundColor: Colors.white70, actions: [
              IconButton(
                  onPressed: () {
                    if (_richTextController.hasUndo) _richTextController.undo();
                  },
                  icon: const Icon(Icons.undo)),
              IconButton(
                  onPressed: () {
                    if (_richTextController.hasRedo) _richTextController.redo();
                  },
                  icon: const Icon(Icons.redo)),
            ]),
            resizeToAvoidBottomInset: false,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.endDocked,
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              child: const Icon(CupertinoIcons.pen),
            ),
            body: QuillEditor(
              autoFocus: true,
              expands: true,
              focusNode: _focusNode,
              controller: _richTextController,
              scrollController: _scrollController,
              scrollable: true,
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 55,
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
