import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';

Future<File?> compressImage(File file) async {
  final dir = await getTemporaryDirectory();
  final targetPath = '${dir.absolute.path}/temp.png';

  var result = await FlutterImageCompress.compressAndGetFile(
    file.absolute.path,
    targetPath,
    quality: 20, // 0–100 (lower = more compression)
    format: CompressFormat.png,
  );
  return File(result!.path);
}

Future<String> fileToBase64(File file) async {
  final bytes = await file.readAsBytes();
  return base64Encode(bytes);
}
