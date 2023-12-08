import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:headset_connection_event/headset_event.dart';
import 'package:web_socket_channel/io.dart';
import 'package:selaras_v01/constants.dart';
import 'screen_layout.dart';
import '../services/api_service.dart';
import '../services/data_notifier.dart';
import '../services/headset_notifier.dart';
import '../services/call_notifier.dart';
//import 'archive/app_title.dart';

class LoadingScreen extends StatefulWidget {
  LoadingScreen({Key? key}) : super(key: key);
  final ApiService apiService = ApiService();

  @override
  LoadingScreenState createState() => LoadingScreenState();
}

class LoadingScreenState extends State<LoadingScreen> {
  /// Variabel untuk persiapan database API
  late Future<List<dynamic>> _futureData;

  /// Variabel untuk mengurus headset
  final _headsetPlugin = HeadsetEvent();
  HeadsetState? _headsetState;

  /// Variabel untuk mengurus call websocket
  late CallNotifier callNotifier;
  late bool _checkConnection = true;
  late Timer _heartbeatTimer;
  late String _wsStatus = 'connected';

  /// Menghubungi websocket begitu aplikasi dijalankan
  IOWebSocketChannel channel = IOWebSocketChannel.connect(wsAddress);

  /// Mengambil data dari database API
  void setupData() {
    _futureData = _fetchData();
  }

  /// Notifier ketika status headset berubah
  void onHeadsetStatusChanged(bool isConnected) {
    final notifier = Provider.of<HeadsetStatusNotifier>(context, listen: false);
    notifier.updateHeadsetStatus(isConnected);
  }

  /// Menyiapkan pemeriksaan status headset
  void setupHeadset() {
    // Meminta izin (khusus untuk Android 12 ke atas)
    _headsetPlugin.requestPermission();

    // Baca status headset
    _headsetPlugin.getCurrentState.then((val) {
      setState(() {
        _headsetState = val;
        onHeadsetStatusChanged(_headsetState == HeadsetState.CONNECT);
      });
    });

    // Deteksi saat headset dipasang atau dilepas
    _headsetPlugin.setListener((val) {
      setState(() {
        _headsetState = val;
        onHeadsetStatusChanged(_headsetState == HeadsetState.CONNECT);
      });
    });
  }

  /// Buat koneksi batu ke websocket, dan aktifkan hearbeat
  void connectWebSocket() {
    // Informasikan websocket server bahwa Device ini sudah connect
    channel.sink.add('C:$deviceID');
    // Ambil jika ada message yang masuk dari websocket
    channel.stream.listen((message) {
      callNotifier.receiveMessage(message, channel);
      _checkConnection = true;
      if (_wsStatus == 'disconnected') _wsStatus = 'connected';
    });
    _heartBeatCheck();
  }

  /// HeartBeat: mengecek koneksi setiap 5 detik
  /// Yaitu mengirim message 'PING' dan server akan membalas dengan 'PONG'
  void _heartBeatCheck() {
    _heartbeatTimer = Timer.periodic(Duration(seconds: 5), (timer) async {
      if (_checkConnection == false) {
        _wsStatus = 'disconnected';
        callNotifier.receiveMessage('DISCONNECT', channel);
        _heartbeatTimer.cancel();
        channel.sink.close();
        // Buat channel baru dan pindahkan channel ke situ
        try {
          IOWebSocketChannel newchannel = IOWebSocketChannel.connect(wsAddress,
              connectTimeout: Duration(seconds: 3));
          channel = newchannel;
          _checkConnection = true;
        } catch (error) {
          _checkConnection = false;
        }
        connectWebSocket();
      } else {
        if (_wsStatus == 'connected') {
          callNotifier.receiveMessage('CONNECT', channel);
          _wsStatus = "online";
        }

        // Set false dulu sbg default
        _checkConnection = false;
        channel.sink.add('P:$deviceID');
      }
    });
  }

  /// Menyiapkan pemanggilan ke websocket
  void setupCall() async {
    // Ambil ID dari device
    await setupDeviceID();
    // Buat notifier untuk consumer widgets yang membutuhkan status call
    callNotifier = Provider.of<CallNotifier>(context, listen: false);
    connectWebSocket();
  }

  @override
  void initState() {
    super.initState();
    setupData();
    setupHeadset();
    setupCall();
  }

  Future<List<dynamic>> _fetchData() async {
    try {
      final data = await widget.apiService.fetchData();
      Provider.of<DataNotifier>(context, listen: false).updateData(data);
      return data;
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching data: $error');
      }
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
//      appBar: appTitle(context: context),
      body: SafeArea(
        child: FutureBuilder<List<dynamic>>(
          future: _futureData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Kesalahan: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return const Center(child: Text('Data tidak tersedia'));
            } else {
              final List<dynamic> data = snapshot.data!;
              return ScreenLayout(
                appData: data,
              );
            }
          },
        ),
      ),
    );
  }
}
