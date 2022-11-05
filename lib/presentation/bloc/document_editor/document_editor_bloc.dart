import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:core/core/model/document.dart';
import 'package:core/core/repository/document_repository.dart';
import 'package:documenteditor/presentation/bloc/document_list/document_list_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:rxdart/transformers.dart';
part 'document_editor_event.dart';
part 'document_editor_state.dart';

class DocumentEditorBloc
    extends Bloc<DocumentEditorEvent, DocumentEditorState> {
  final DocumentRepository _documentRepository;
  final DocumentListBloc _documentListBloc;

  DocumentEditorBloc(this._documentRepository, this._documentListBloc)
      : super(DocumentEditorInitial()) {
    stream.whereType<DocumentEditorChangeEvent>().listen((state) {});
    on<DocumentEditorChangeEvent>(
      (event, emit) {
        emit(DocumentEditorChangeUnsaved());
      },
      transformer: (events, mapper) => events
          .debounceTime(const Duration(milliseconds: 500))
          .asyncExpand(mapper),
    );

    on<DocumentEditorSaveEvent>((event, emit) async {
      if (event is DocumentEditorCreateEvent) {
        await _handleCreateDocument(emit, event);
      } else if (event is DocumentEditorUpdateEvent) {
        await _handleUpdateDocument(emit, event);
      }
    }, transformer: sequential());

    stream.whereType<DocumentEditorChangeUpdated>().listen((state) {
      _documentListBloc
          .add(OnDocumentListUpdate(document: state.updatedDocument));
    });

    stream.whereType<DocumentEditorChangeCreated>().listen((state) {
      _documentListBloc
          .add(OnDocumentListAdd(documents: [state.createdDocument]));
    });
  }

  Future<void> _handleUpdateDocument(Emitter<DocumentEditorState> emit,
      DocumentEditorUpdateEvent event) async {
    emit(DocumentEditorChangeSaving());
    final response = await _documentRepository.updateDocument(
        event.documentFile,
        title: event.title,
        data: event.data);

    emit(response.fold(
        (exception) => DocumentEditorChangeSavingError(exception: exception),
        (updatedDocument) =>
            DocumentEditorChangeUpdated(updatedDocument: updatedDocument)));
  }

  Future<void> _handleCreateDocument(Emitter<DocumentEditorState> emit,
      DocumentEditorCreateEvent event) async {
    emit(DocumentEditorChangeSaving());
    final response = await _documentRepository.createDocuments(
        [DocumentFile.create(title: event.title, data: event.data)]);

    emit(response.fold(
        (exception) => DocumentEditorChangeSavingError(exception: exception),
        (updatedDocument) => updatedDocument.isNotEmpty
            ? DocumentEditorChangeCreated(
                createdDocument: updatedDocument.first)
            : DocumentEditorChangeSaved()));
  }
}
