import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screen_layout.dart';
import '../data/api_service.dart';
import '../data/data_provider.dart';
//import 'archive/app_title.dart';

class LoadingScreen extends StatefulWidget {
  LoadingScreen({Key? key}) : super(key: key);

  final ApiService apiService = ApiService();

  @override
  LoadingScreenState createState() => LoadingScreenState();
}

class LoadingScreenState extends State<LoadingScreen> {
  late Future<List<dynamic>> _futureData;

  @override
  void initState() {
    super.initState();
    _futureData = _fetchData();
  }

  Future<List<dynamic>> _fetchData() async {
    try {
      final data = await widget.apiService.fetchData();
      Provider.of<DataProvider>(context, listen: false).updateData(data);
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
