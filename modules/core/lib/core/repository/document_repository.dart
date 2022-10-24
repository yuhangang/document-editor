import 'package:core/core/model/document.dart';
import 'package:dartz/dartz.dart';

abstract class DocumentRepository {
  Future<Either<Exception, List<DocumentFile>>> getDocuments();
  Future<Either<Exception, DocumentFile?>> updateDocument(
      DocumentFile documentFile);
  Future<Exception?> createDocuments(List<DocumentFile> documents);
  Future<Exception?> deleteDocuments(List<DocumentFile> documents);
}
