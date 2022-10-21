import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class RichTextToolbar extends StatelessWidget {
  const RichTextToolbar.mobile({
    Key? key,
    required this.showFullToolBar,
    required QuillController richTextController,
  })  : _richTextController = richTextController,
        _isMobileLayout = true,
        super(key: key);

  const RichTextToolbar.desktop({
    Key? key,
    required this.showFullToolBar,
    required QuillController richTextController,
  })  : _richTextController = richTextController,
        _isMobileLayout = false,
        super(key: key);

  final ValueNotifier<bool> showFullToolBar;
  final QuillController _richTextController;
  final bool _isMobileLayout;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder<bool>(
          valueListenable: showFullToolBar,
          builder: (context, show, child) {
            return GestureDetector(
              behavior: HitTestBehavior.translucent,
              onVerticalDragUpdate: (dragEndDetails) {
                if ((dragEndDetails.primaryDelta ?? 0) < 0 && !show) {
                  showFullToolBar.value = true;
                } else if ((dragEndDetails.primaryDelta ?? 0) > 0 && show) {
                  showFullToolBar.value = false;
                }
              },
              child: !_isMobileLayout
                  ? handleDesktopLayout()
                  : show
                      ? QuillToolbar.basic(
                          toolbarIconSize: 22,
                          toolbarIconAlignment: WrapAlignment.start,
                          showHeaderStyle: false,
                          showCodeBlock: false,
                          showRedo: false,
                          showUndo: false,
                          showAlignmentButtons: true,
                          controller: _richTextController)
                      : QuillToolbar.basic(
                          toolbarIconSize: 22,
                          toolbarIconAlignment: WrapAlignment.start,
                          controller: _richTextController,
                          showRedo: false,
                          showUndo: false,
                          showAlignmentButtons: true,
                          showCenterAlignment: true,
                          showLeftAlignment: true,
                          showRightAlignment: true,
                          showHeaderStyle: false,
                          showCodeBlock: false,
                          showInlineCode: false,
                          showListBullets: false,
                          showListCheck: false,
                          showBackgroundColorButton: false,
                          showSearchButton: false,
                          showSmallButton: false,
                          showIndent: false,
                          showColorButton: false,
                          showFontFamily: false,
                          showFontSize: false,
                          showListNumbers: false,
                          showDividers: false,
                          showStrikeThrough: false,
                          showDirection: false,
                          showClearFormat: false,
                          showQuote: false,
                        ),
            );
          }),
    );
  }

  Widget handleDesktopLayout() => QuillToolbar.basic(
      toolbarIconAlignment: WrapAlignment.start,
      toolbarIconSize: 22,
      showHeaderStyle: false,
      showCodeBlock: false,
      showAlignmentButtons: true,
      controller: _richTextController);
}
