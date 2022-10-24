part of 'document_list_bloc.dart';

abstract class DocumentListState extends Equatable {
  const DocumentListState();

  @override
  List<Object> get props => [];
}

class DocumentListInitial extends DocumentListState {}

class DocumentListLoading extends DocumentListState {}

class DocumentListLoaded extends DocumentListState {
  final List<DocumentFile> documents;
  final DateTime loadedAt;

  DocumentListLoaded({
    required this.documents,
  }) : loadedAt = DateTime.now();

  @override
  List<Object> get props => documents;
}

class DocumentListFailed extends DocumentListState {
  final Exception exception;
  const DocumentListFailed({
    required this.exception,
  });

  @override
  List<Object> get props => [exception];
}
