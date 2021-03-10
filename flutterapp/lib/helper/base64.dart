// Dart imports:
import 'dart:convert';
import 'dart:io';

// Package imports:
import 'package:path_provider/path_provider.dart' as p;

Future<File> base64ToImage(String base64, String name) async {
  final decodedBytes = base64Decode(base64);
  final dir = await p.getExternalStorageDirectory();
  final imageFile = File(
    dir.path + '/doctor/' + name + '.png',
  );
  final result = await imageFile.writeAsBytes(decodedBytes);
  return result;
}
