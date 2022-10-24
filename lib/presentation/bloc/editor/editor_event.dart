part of 'editor_bloc.dart';

abstract class DocumentEditorEvent extends Equatable {
  const DocumentEditorEvent();

  @override
  List<Object> get props => [];
}

class DocumentEditorChangeEvent extends DocumentEditorEvent {
  const DocumentEditorChangeEvent();
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

class DocumentEditorSaveEvent extends DocumentEditorEvent {
  final dynamic json;
  const DocumentEditorSaveEvent({
    required this.json,
  });
}
