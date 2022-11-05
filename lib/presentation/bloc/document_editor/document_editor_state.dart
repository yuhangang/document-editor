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

class DocumentEditorChangeUpdated extends DocumentEditorChangeSaved {
  final DocumentFile updatedDocument;
  DocumentEditorChangeUpdated({
    required this.updatedDocument,
  });
}

class DocumentEditorChangeCreated extends DocumentEditorChangeSaved {
  final DocumentFile createdDocument;
  DocumentEditorChangeCreated({
    required this.createdDocument,
  });
}
