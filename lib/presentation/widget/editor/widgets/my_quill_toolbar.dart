import 'dart:io';

import 'package:core/core/di/service_locator.dart';
import 'package:core/core/repository/attachment_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';

class RichTextToolbar extends StatelessWidget {
  const RichTextToolbar.mobile({
    Key? key,
    required this.showFullToolBar,
    required QuillController richTextController,
    required this.focusNode,
  })  : _richTextController = richTextController,
        _isMobileLayout = true,
        super(key: key);

  const RichTextToolbar.desktop(
      {Key? key,
      required this.showFullToolBar,
      required QuillController richTextController,
      required this.focusNode})
      : _richTextController = richTextController,
        _isMobileLayout = false,
        super(key: key);

  final ValueNotifier<bool> showFullToolBar;
  final QuillController _richTextController;
  final bool _isMobileLayout;
  final FocusNode focusNode;

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
                          controller: _richTextController,
                          embedButtons: FlutterQuillEmbeds.buttons(
                            // provide a callback to enable picking images from device.
                            // if omit, "image" button only allows adding images from url.
                            // same goes for videos.
                            onImagePickCallback: _onImagePickCallback,
                            // onVideoPickCallback: _onVideoPickCallback,
                            // uncomment to provide a custom "pick from" dialog.
                            // mediaPickSettingSelector: _selectMediaPickSetting,
                            // uncomment to provide a custom "pick from" dialog.
                            // cameraPickSettingSelector: _selectCameraPickSetting,
                          ),
                          //     showAlignmentButtons: true,
                          afterButtonPressed: focusNode.requestFocus,
                        )
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

// Renders the image picked by imagePicker from local file storage
// You can also upload the picked image to any server (eg : AWS s3
// or Firebase) and then return the uploaded image URL.
Future<String> _onImagePickCallback(File file) async {
  // Copies the picked file from temporary cache to applications directory
  final response = await sl.get<AttachmentRepository>().uploadImage(file);
  return response.fold((exception) => throw (exception), (r) => r);
}

/*
// Renders the video picked by imagePicker from local file storage
// You can also upload the picked video to any server (eg : AWS s3
// or Firebase) and then return the uploaded video URL.
Future<String> _onVideoPickCallback(File file) async {
  // Copies the picked file from temporary cache to applications directory
  final appDocDir = await getApplicationDocumentsDirectory();
  final copiedFile =
      await file.copy('${appDocDir.path}/${basename(file.path)}');
  return copiedFile.path.toString();
}
*/
