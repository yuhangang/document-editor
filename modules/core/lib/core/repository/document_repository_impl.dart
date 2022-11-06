import 'dart:io';

import 'package:core/core/api/document_api_provider.dart';
import 'package:core/core/commons/error/exceptions.dart';
import 'package:core/core/model/document.dart';
import 'package:core/core/repository/document_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:isar/isar.dart';

class DocumentRepositoryImpl implements DocumentRepository {
  final DocumentApiProvider documentApiProvider;
  final Isar isar;
  DocumentRepositoryImpl({
    required this.documentApiProvider,
    required this.isar,
  });

  @override
  Future<Either<Exception, List<DocumentFile>>> getCachedDocuments() async {
    try {
      final documentList = await isar.documentFiles.where().findAll();

      return Right(documentList);
      //return Right();
    } catch (e) {
      return Left(e is Exception ? e : UnknownException());
    }
  }

  @override
  Future<Either<Exception, List<DocumentFile>>> getDocuments() async {
    try {
      final documentList = await documentApiProvider.getDocumentList();
      await isar.writeTxn(() async {
        await isar.documentFiles.clear();
        await isar.documentFiles.putAll(documentList);

        // await isar.documentFiles.filter()
        // .anyOf<String,Object>(
        //   documentList.map((e) => e.deviceId).whereType<String>(), (q, element) => null)
      });

      return Right(documentList);
      //return Right();
    } catch (e) {
      return Left(e is Exception ? e : UnknownException());
    }
  }

  @override
  Future<Either<Exception, List<DocumentFile>>> createDocuments(
      List<DocumentFile> documents) async {
    try {
      final data = await documentApiProvider.addDocument(documents.first);
      await isar.writeTxn(() async {
        await isar.documentFiles.putAll([data]);
      });

      return right([data]);
    } catch (e) {
      if (e is SocketException) {
        await isar.writeTxn(() async {
          await isar.documentFiles.putAll(documents);
        });
        return right([]);
      }
      return Left(e is Exception ? e : UnknownException());
    }
  }

  @override
  Future<Exception?> deleteDocuments(DocumentFile document) async {
    try {
      await documentApiProvider.deleteDocument(document.documentId!);
      await isar.writeTxn(() async {
        await isar.documentFiles.delete(document.id);
      });

      return null;
    } catch (e) {
      return e is Exception ? e : UnknownException();
    }
  }

  @override
  Future<Either<Exception, DocumentFile>> getDocument(
      DocumentFile documentFile) async {
    try {
      final data =
          await documentApiProvider.getDocumentByid(documentFile.documentId!);
      await isar.writeTxn<DocumentFile?>(() async {
        final id = await isar.documentFiles.put(data);
        return await isar.documentFiles.get(id);
      });

      return Right(data);
    } catch (e) {
      return Left(e is Exception ? e : UnknownException());
    }
  }

  @override
  Future<Either<Exception, DocumentFile>> updateDocument(
      DocumentFile documentFile,
      {required String title,
      required String data}) async {
    try {
      final updatedDocument = await documentApiProvider.updateDocument(
          documentFile.documentId!,
          documentFile.getUpdateContent(title: title, data: data));
      await isar.writeTxn<DocumentFile?>(() async {
        final id = await isar.documentFiles.put(updatedDocument);
        return await isar.documentFiles.get(id);
      });

      return Right(updatedDocument);
    } catch (e) {
      return Left(e is Exception ? e : UnknownException());
    }
  }
}
