import 'package:core/core/model/document.dart';
import 'package:dartz/dartz.dart';

abstract class DocumentRepository {
  Future<Either<Exception, List<DocumentFile>>> getCachedDocuments();
  Future<Either<Exception, List<DocumentFile>>> getDocuments();
  Future<Either<Exception, DocumentFile>> updateDocument(
      DocumentFile documentFile,
      {required String title,
      required String data});
  Future<Either<Exception, DocumentFile>> getDocument(
      DocumentFile documentFile);
  Future<Either<Exception, List<DocumentFile>>> createDocuments(
      List<DocumentFile> documents);
  Future<Exception?> deleteDocuments(List<DocumentFile> documents);
}
