import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_quill/flutter_quill.dart';
part 'editor_event.dart';
part 'editor_state.dart';

class DocumentEditorBloc
    extends Bloc<DocumentEditorEvent, DocumentEditorState> {
  DocumentEditorBloc() : super(DocumentEditorInitial()) {
    on<DocumentEditorChangeEvent>(
      (event, emit) {
        emit(DocumentEditorChangeUnsaved());
      },
    );

    on<DocumentEditorSaveEvent>(
      (event, emit) {
        emit(DocumentEditorChangeSaved());
      },
    );
  }
}
