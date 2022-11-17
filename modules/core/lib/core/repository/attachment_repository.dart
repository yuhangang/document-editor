import 'dart:io';

import 'package:core/core/api/attachment_api_provider.dart';
import 'package:core/core/commons/error/exceptions.dart';
import 'package:core/core/commons/utils/image/image_compression_helper.dart';
import 'package:dartz/dartz.dart';

abstract class AttachmentRepository {
  Future<Either<Exception, String>> uploadImage(File file);
}

class AttachmentRepositoryImpl implements AttachmentRepository {
  final ImageCompressionHelper _imageCompressionHelper;
  final AttachmentApiProvider _attachmentApiProvider;

  AttachmentRepositoryImpl(
    this._imageCompressionHelper,
    this._attachmentApiProvider,
  );

  @override
  Future<Either<Exception, String>> uploadImage(File file) async {
    try {
      final compressedFile =
          await _imageCompressionHelper.compressAndGetFile(file);
      final response =
          await _attachmentApiProvider.addAttachment(compressedFile);
      return right(response);
    } catch (e) {
      return Left(e is Exception ? e : UnknownException());
    }
  }
}
