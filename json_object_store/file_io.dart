import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileIo {
  Future<String> get _localPath async {
    final dir = await getApplicationDocumentsDirectory();
    return dir!.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    print(path);
    final file = File('$path/my_file.txt');

    if (!await file.exists()) {
      await file.create(
        recursive: true,
      ); // `recursive: true` creates parent directories if they don't exist
    }

    return file;
  }

  Future<List<String>> readFile() async {
    final file = await _localFile;
    return await file.readAsLines();
  }

  Future<void> writeToFile(String content) async {
    final file = await _localFile;
    await file.writeAsString(
      Platform.lineTerminator + content,
      mode: FileMode.append,
    );
  }
}
