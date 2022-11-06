part of 'document_editor_bloc.dart';

abstract class DocumentEditorState extends Equatable {
  const DocumentEditorState();

  @override
  List<Object> get props => [];
}

class DocumentEditorInitial extends DocumentEditorState {}

class DocumentEditorChangeUnsaved extends DocumentEditorState {}

class DocumentEditorChangeSavingError extends DocumentEditorChangeUnsaved {
  final Exception exception;
  DocumentEditorChangeSavingError({
    required this.exception,
  });
}

class DocumentEditorChangeSaving extends DocumentEditorState {}

class DocumentEditorChangeSaved extends DocumentEditorState {}

class DocumentEditorFileUpdated extends DocumentEditorChangeSaved {
  final DocumentFile updatedDocument;
  DocumentEditorFileUpdated({
    required this.updatedDocument,
  });
}

class DocumentEditorFileCreated extends DocumentEditorChangeSaved {
  final DocumentFile createdDocument;
  DocumentEditorFileCreated({
    required this.createdDocument,
  });
}

class DocumentEditorChangeDeleted extends DocumentEditorState {
  final DocumentFile createdDocument;
  const DocumentEditorChangeDeleted({
    required this.createdDocument,
  });
}
