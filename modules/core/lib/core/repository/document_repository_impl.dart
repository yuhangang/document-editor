import 'package:core/core/commons/error/exceptions.dart';
import 'package:core/core/model/document.dart';
import 'package:core/core/repository/document_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:isar/isar.dart';

class DocumentRepositoryImpl implements DocumentRepository {
  final Isar isar;
  DocumentRepositoryImpl({
    required this.isar,
  });

  @override
  Future<Either<Exception, List<DocumentFile>>> getDocuments() async {
    try {
      return Right(await isar.documentFiles.where().findAll());
    } catch (e) {
      return Left(e is Exception ? e : UnknownException());
    }
  }

  @override
  Future<Exception?> createDocuments(List<DocumentFile> documents) async {
    try {
      await isar.writeTxn(() async {
        await isar.documentFiles.putAll(documents);
      });

      return null;
    } catch (e) {
      return e is Exception ? e : UnknownException();
    }
  }

  @override
  Future<Exception?> deleteDocuments(List<DocumentFile> documents) async {
    try {
      await isar.writeTxn(() async {
        await isar.documentFiles.deleteAll(documents.map((e) => e.id).toList());
      });

      return null;
    } catch (e) {
      return e is Exception ? e : UnknownException();
    }
  }

  @override
  Future<Either<Exception, DocumentFile?>> updateDocument(
      DocumentFile documentFile) async {
    try {
      final item = await isar.writeTxn<DocumentFile?>(() async {
        final id = await isar.documentFiles.put(documentFile);
        return await isar.documentFiles.get(id);
      });

      return Right(item);
    } catch (e) {
      return Left(e is Exception ? e : UnknownException());
    }
  }
}
