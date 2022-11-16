import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

enum ImageCompressionQuality {
  low(44),
  medium(66),
  high(88);

  const ImageCompressionQuality(this.num);
  final int num;
}

abstract class ImageCompressionHelper {
  Future<File> compressAndGetFile(File file,
      {ImageCompressionQuality quality = ImageCompressionQuality.medium});
}

class ImageCompressionHelperImpl implements ImageCompressionHelper {
  @override
  Future<File> compressAndGetFile(File file,
      {ImageCompressionQuality quality =
          ImageCompressionQuality.medium}) async {
    final appDocDir = await getApplicationDocumentsDirectory();
    final result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      '${appDocDir.path}/${basename(file.absolute.path)}',
      quality: quality.num,
      rotate: 180,
    );

    return result!;
  }
}
