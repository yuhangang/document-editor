import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:documenteditor/presentation/widget/editor/widgets/rich_text_toolbar.dart';

class EditorPageMobileTabletDesktop extends StatelessWidget {
  const EditorPageMobileTabletDesktop({
    Key? key,
    required QuillController richTextController,
    required FocusNode focusNode,
    required ScrollController scrollController,
    required this.showFullToolBar,
    required this.isMobileLayout,
    required Animation<double> animation,
    required this.onSaved,
  })  : _richTextController = richTextController,
        _focusNode = focusNode,
        _scrollController = scrollController,
        super(key: key);

  final QuillController _richTextController;
  final FocusNode _focusNode;
  final ScrollController _scrollController;
  final ValueNotifier<bool> showFullToolBar;
  final bool isMobileLayout;
  final VoidCallback onSaved;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          RichTextToolbar.desktop(
              showFullToolBar: showFullToolBar,
              richTextController: _richTextController),
          Expanded(
            child: QuillEditor(
              autoFocus: true,
              expands: true,

              focusNode: _focusNode,
              controller: _richTextController,
              scrollController: _scrollController,
              scrollable: true,
              padding: const EdgeInsets.only(
                  top: 50, left: 16, right: 16, bottom: 50),
              readOnly: false, // true for view only mode
            ),
          )
        ],
      ),
    );
  }
}
