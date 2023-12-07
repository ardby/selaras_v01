import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:selaras_v01/constants.dart';

class CallNotifier extends ChangeNotifier {
  final _messageController = StreamController<String>();
  String _receivedMessage = '';
  Stream<String> get messageStream => _messageController.stream;
  String get receivedMessage => _receivedMessage;

  void receiveMessage(String message, IOWebSocketChannel channel) {
    /// Acknowledge server dengan Device ID
    /// Device ID ini seharusnya dicek dulu di file di device apakah ada
    /// Jika sudah ada, ambil dari file itu dan jika blm ada maka tulis ke situ
    if (message != "DISCONNECT") channel.sink.add('R:$deviceID:$message');
    _receivedMessage = message; // Simpan pesan yang diterima
    // Emit pesan ke dalam stream controller untuk digunakan dalam aplikasi
    _messageController.add(message);
    // Pemberitahuan bahwa terjadi perubahan pada data
    if (message != "PONG") notifyListeners();
  }

  @override
  void dispose() {
    _messageController.close();
    super.dispose();
  }
}
