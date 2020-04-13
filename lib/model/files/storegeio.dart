import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class StorageIO {
  final String filename;

  const StorageIO({this.filename = ""});

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  //TO DO: 
  Future<String> getPath(String path) async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;

    if(this.filename == "") {
      throw Exception("Erro ao tentar recuperar dados do arquivo $filename.");
    } else {
      return File('$path/$filename');
    }
  }

  Future<dynamic> readAndConvertEntireFileToJSON() async {
    try {
      final file = await _localFile;

      String contents = await file.readAsString();

      return json.decode(contents);
    } catch (e) {
      throw Exception("Erro ao tentar recuperar dados do arquivo $filename.");
    }
  }

  Future<File> write(String content) async {
    try {
      final file = await _localFile;

      return file.writeAsString('$content');
    } catch (e) {
      throw Exception("Erro ao tentar gravar dados no arquivo $filename.");
    }
  }

}