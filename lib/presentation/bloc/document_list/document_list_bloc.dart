import 'package:bloc/bloc.dart';
import 'package:core/core/model/document.dart';
import 'package:core/core/repository/document_repository.dart';
import 'package:equatable/equatable.dart';

part 'document_list_event.dart';
part 'document_list_state.dart';

class DocumentListBloc extends Bloc<DocumentListEvent, DocumentListState> {
  final DocumentRepository _documentRepository;

  DocumentListBloc(
    this._documentRepository,
  ) : super(DocumentListInitial()) {
    on<OnDocumentListAdd>((event, emit) async {
      final exception =
          await _documentRepository.createDocuments(event.documents);
      if (exception == null) {
        add(OnDocumentListLoad());
      }
    });

    on<OnDocumentListUpdate>((event, emit) async {
      final exception =
          await _documentRepository.updateDocument(event.document);
      if (exception.isRight()) {
        add(OnDocumentListLoad());
      }
    });

    on<OnDocumentListDelete>((event, emit) async {
      final exception =
          await _documentRepository.deleteDocuments(event.documents);
      if (exception == null) {
        add(OnDocumentListLoad());
      }
    });

    on<OnDocumentListLoad>((event, emit) async {
      final documentListResponse = await _documentRepository.getDocuments();
      emit(documentListResponse.fold(
          (exception) => DocumentListFailed(exception: exception),
          (documentList) => DocumentListLoaded(documents: documentList)));
    });
  }
}
