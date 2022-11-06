part of 'document_list_bloc.dart';

abstract class DocumentListEvent extends Equatable {
  const DocumentListEvent();

  @override
  List<Object> get props => [];
}

class OnDocumentListLoad extends DocumentListEvent {}

class OnDocumentListLoadCached extends DocumentListEvent {}

class OnDocumentListAdd extends DocumentListEvent {
  final List<DocumentFile> documents;
  const OnDocumentListAdd({
    required this.documents,
  });
}

class OnDocumentListUpdate extends DocumentListEvent {
  final DocumentFile document;
  const OnDocumentListUpdate({
    required this.document,
  });
}

class OnDocumentListDelete extends DocumentListEvent {
  final DocumentFile document;
  const OnDocumentListDelete({
    required this.document,
  });
}
