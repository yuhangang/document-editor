import 'dart:convert';

import 'package:core/core/model/document.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:go_router/go_router.dart';

import 'package:weatherapp/presentation/bloc/document_list/document_list_bloc.dart';
import 'package:weatherapp/presentation/bloc/editor/editor_bloc.dart';
import 'package:weatherapp/presentation/widget/editor/widgets/editor_page_desktop.dart';
import 'package:weatherapp/presentation/widget/editor/widgets/editor_page_mobile.dart';

class EditorPage extends StatefulWidget {
  final DocumentFile? document;
  const EditorPage({
    Key? key,
    this.document,
  }) : super(key: key);

  @override
  State<EditorPage> createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> with TickerProviderStateMixin {
  late final Document document;
  final TextSelection _textSelection = const TextSelection.collapsed(offset: 0);
  late final QuillController _richTextController;
  final ValueNotifier<bool> showFullToolBar = ValueNotifier(false);
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();
  late final DocumentEditorBloc _editorBloc;
  late final DocumentListBloc _documentListBloc;
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
  late final TextEditingController _titleController;

  @override
  void initState() {
    _editorBloc = BlocProvider.of<DocumentEditorBloc>(context);
    _documentListBloc = BlocProvider.of<DocumentListBloc>(context);

    document = widget.document != null
        ? Document.fromJson(List.from(jsonDecode(widget.document!.data)))
        : Document();
    _richTextController =
        QuillController(document: document, selection: _textSelection);
    _titleController = TextEditingController(text: widget.document?.title);

    // listen to editor changed by user
    document.changes
        .where((event) => event.item3 == ChangeSource.LOCAL)
        .listen((event) {
      _editorBloc.add(DocumentEditorChangeContentEvent(
          before: event.item1, after: event.item2, source: event.item3));
    });

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
    return WillPopScope(
      onWillPop: () async {
        if (_editorBloc.state is DocumentEditorChangeUnsaved) {
          bool shouldQuit = false;
          await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  content: const Text(
                      "You save unsaved changes, still want to leave?"),
                  actions: [
                    TextButton(
                      child: const Text("Yes"),
                      onPressed: () {
                        shouldQuit = true;
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: const Text("No"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              });
          return shouldQuit;
        }
        return true;
      },
      child: RawGestureDetector(
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
                animation: _animation,
                titleController: _titleController,
                onSaved: () {
                  if (widget.document != null) {
                    _documentListBloc.add(OnDocumentListUpdate(
                        document: widget.document!.copyWith(
                            title: _titleController.text,
                            data: jsonEncode(document.toDelta().toJson()))));
                  } else {
                    _documentListBloc.add(OnDocumentListAdd(documents: [
                      DocumentFile.create(
                          title: _titleController.text,
                          data: jsonEncode(document.toDelta().toJson()))
                    ]));
                  }
                  GoRouter.of(context).pop();
                },
                onChangedTitle: (_) {
                  _editorBloc.add(const DocumentEditorChangeEvent());
                },
              )
            : EditorPageMobileTabletDesktop(
                richTextController: _richTextController,
                focusNode: _focusNode,
                scrollController: _scrollController,
                showFullToolBar: showFullToolBar,
                isMobileLayout: isMobileLayout,
                animation: _animation,
                onSaved: () {
                  _documentListBloc.add(OnDocumentListAdd(documents: [
                    DocumentFile.create(
                        title: "",
                        data: jsonEncode(document.toDelta().toJson()))
                  ]));
                },
              ),
      ),
    );
  }
}
