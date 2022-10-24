part of 'editor_bloc.dart';

abstract class DocumentEditorState extends Equatable {
  const DocumentEditorState();

  @override
  List<Object> get props => [];
}

class DocumentEditorInitial extends DocumentEditorState {}

class DocumentEditorChangeUnsaved extends DocumentEditorState {}

class DocumentEditorChangeSaved extends DocumentEditorState {}
