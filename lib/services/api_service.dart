import 'dart:convert';
import "package:http/http.dart" as http;

class ApiService {
  static const kAPIKey =
      '7c6c731f9be1dd5295f2a058a16eacc3357dd625d67e2f0ccc1c88765c2aaa7d';
  static const kAPIUrl =
      'https://izaunet.com/spbe/api/api_spbe.php?key=$kAPIKey&api=';
  static const String urlGetData = '${kAPIUrl}getcards';
  static const String urlSetChoice = '${kAPIUrl}setchoice';
  static const String urlSetDesc = '${kAPIUrl}setdesc';
  static const String urlSetSupport = '${kAPIUrl}setsupport';
  static const String urlGetProgress = '${kAPIUrl}getprogress';

  Future<List<dynamic>> fetchData() async {
    final response = await http.get(Uri.parse(urlGetData));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data as List<dynamic>;
    } else {
      throw Exception(
          'Gagal Membuka Aplikasi. Mohon Periksa Koneksi Internet Anda');
    }
  }

  Future<void> setChoice({
    required int qid,
    required int choiceno,
  }) async {
    await http.get(Uri.parse('$urlSetChoice&qid=$qid&choiceno=$choiceno'));
  }

  Future<void> setDesc({
    required int qid,
    required String desc,
  }) async {
    await http.get(Uri.parse('$urlSetDesc&qid=$qid&desc=$desc'));
  }

  Future<void> setSupport({
    required int qid,
    required int support,
  }) async {
    await http.get(Uri.parse('$urlSetSupport&qid=$qid&support=$support'));
  }

  Future<double> getProgress() async {
    final response = await http.get(Uri.parse(urlGetProgress));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return double.parse(data['progress']);
    } else {
      throw Exception(
          'Gagal Membuka Aplikasi. Mohon Periksa Koneksi Internet Anda');
    }
  }
}
