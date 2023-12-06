import 'dart:io';
import 'package:uuid/uuid.dart';
import 'package:path_provider/path_provider.dart';

class IdManager {
  final String _fileName = 'selaras_id.txt';
  final Uuid _uuid = Uuid();

  Future<String> getID() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$_fileName');

    if (file.existsSync()) {
      // Jika file sudah ada, baca ID dari file
      return file.readAsStringSync();
    } else {
      // Jika file belum ada, buat ID baru, simpan ke dalam file, dan kembalikan ID
      final newId = _uuid.v4();
      await file.writeAsString(newId);
      return newId;
    }
  }
}
