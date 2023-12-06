import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screen_layout.dart';
import '../services/api_service.dart';
import '../services/data_notifier.dart';
import '../services/headset_notifier.dart';
import '../services/call_notifier.dart';
import 'package:headset_connection_event/headset_event.dart';
import 'package:web_socket_channel/io.dart';
import 'package:selaras_v01/constants.dart';
//import 'archive/app_title.dart';

class LoadingScreen extends StatefulWidget {
  LoadingScreen({Key? key}) : super(key: key);

  final ApiService apiService = ApiService();

  @override
  LoadingScreenState createState() => LoadingScreenState();
}

class LoadingScreenState extends State<LoadingScreen> {
  late Future<List<dynamic>> _futureData;
  final _headsetPlugin = HeadsetEvent();
  HeadsetState? _headsetState;

  void onHeadsetStatusChanged(bool isConnected) {
    final notifier = Provider.of<HeadsetStatusNotifier>(context, listen: false);
    notifier.updateHeadsetStatus(isConnected);
  }

  void setupData() {
    /// Mengambil data dari database API
    _futureData = _fetchData();
  }

  void setupHeadset() {
    /// Meminta izin (khusus untuk Android 12 ke atas)
    _headsetPlugin.requestPermission();

    /// Baca status headset
    _headsetPlugin.getCurrentState.then((val) {
      setState(() {
        _headsetState = val;
        onHeadsetStatusChanged(_headsetState == HeadsetState.CONNECT);
      });
    });

    /// Deteksi saat headset dipasang atau dilepas
    _headsetPlugin.setListener((val) {
      setState(() {
        _headsetState = val;
        onHeadsetStatusChanged(_headsetState == HeadsetState.CONNECT);
      });
    });
  }

  void setupCall() async {
    /// Ambil ID dari device
    await setupDeviceID();

    /// Mengambil data cari call
    final channel = IOWebSocketChannel.connect(wsAddress);

    /// Informasikan websocket server bahwa Device ini sudah connect
    channel.sink.add('C:$deviceID');

    /// Buat notifier untuk consumer widgets yang membutuhkan status call
    final CallNotifier callNotifier =
        Provider.of<CallNotifier>(context, listen: false);

    /// Ambil jika ada message yang masuk dari websocket
    channel.stream.listen((message) {
      callNotifier.receiveMessage(message, channel);
      // Lakukan sesuatu di sini kalau diperlukan
    });
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
