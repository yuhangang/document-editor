import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:weatherapp/presentation/widget/editor/widgets/editor_page_desktop.dart';
import 'package:weatherapp/presentation/widget/editor/widgets/editor_page_mobile.dart';

class EditorPage extends StatefulWidget {
  const EditorPage({Key? key}) : super(key: key);

  @override
  State<EditorPage> createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> with TickerProviderStateMixin {
  final QuillController _richTextController = QuillController.basic();
  final ValueNotifier<bool> showFullToolBar = ValueNotifier(false);
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();
  late final AnimationController _controller = AnimationController(
    value: 0.89,
    upperBound: 0.89,
    lowerBound: 0,
    duration: const Duration(milliseconds: 500),
    vsync: this,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInCirc,
  );
  @override
  void initState() {
    showFullToolBar.addListener(() {
      if (!showFullToolBar.value) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobileLayout = MediaQuery.of(context).size.width < 800;
    return RawGestureDetector(
      gestures: <Type, GestureRecognizerFactory>{
        ImmediateMultiDragGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<
                    ImmediateMultiDragGestureRecognizer>(
                () => ImmediateMultiDragGestureRecognizer(),
                (ImmediateMultiDragGestureRecognizer instance) {}),
      },
      child: isMobileLayout
          ? EditorPageMobile(
              richTextController: _richTextController,
              focusNode: _focusNode,
              scrollController: _scrollController,
              showFullToolBar: showFullToolBar,
              isMobileLayout: isMobileLayout,
              animation: _animation)
          : EditorPageMobileTabletDesktop(
              richTextController: _richTextController,
              focusNode: _focusNode,
              scrollController: _scrollController,
              showFullToolBar: showFullToolBar,
              isMobileLayout: isMobileLayout,
              animation: _animation),
    );
  }
}
