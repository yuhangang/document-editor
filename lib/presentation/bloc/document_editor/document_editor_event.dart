part of 'document_editor_bloc.dart';

abstract class DocumentEditorEvent extends Equatable {
  const DocumentEditorEvent();

  @override
  List<Object> get props => [];
}

abstract class DocumentEditorChangeEvent extends DocumentEditorEvent {
  const DocumentEditorChangeEvent();
}

class DocumentEditorChangeTitleEvent extends DocumentEditorChangeEvent {
  final String title;
  const DocumentEditorChangeTitleEvent({
    required this.title,
  });
}

class DocumentEditorChangeContentEvent extends DocumentEditorChangeEvent {
  final Delta before;
  final Delta after;
  final ChangeSource source;

  const DocumentEditorChangeContentEvent({
    required this.before,
    required this.after,
    required this.source,
  });

  @override
  String toString() => '$before, after: $after, source: $source)';
}

abstract class DocumentEditorSaveEvent extends DocumentEditorEvent {
  const DocumentEditorSaveEvent();
}

class DocumentEditorCreateEvent extends DocumentEditorSaveEvent {
  final String title;
  final String data;
  const DocumentEditorCreateEvent({
    required this.title,
    required this.data,
  });
}

class DocumentEditorUpdateEvent extends DocumentEditorSaveEvent {
  final DocumentFile documentFile;
  final String title;
  final String data;

  const DocumentEditorUpdateEvent({
    required this.documentFile,
    required this.title,
    required this.data,
  });
}
