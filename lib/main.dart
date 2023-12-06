import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/data_notifier.dart';
import 'services/headset_notifier.dart';
import 'services/call_notifier.dart';
import 'screen/loading_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<DataNotifier>(
          create: (context) => DataNotifier(), // Nantinya kalau perlu data API
        ),
        ChangeNotifierProvider<HeadsetStatusNotifier>(
          create: (context) =>
              HeadsetStatusNotifier(), // Provider dari status headset
        ),
        ChangeNotifierProvider<CallNotifier>(
          create: (context) =>
              CallNotifier(), // Provider jika ada panggilan masuk
        ),
      ],
      child: const Selaras(),
    ),
  );
}

class Selaras extends StatelessWidget {
  const Selaras({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = ThemeData.light().copyWith(
      scaffoldBackgroundColor: Colors.white,
    );
    return MaterialApp(
      theme: themeData,
      home: LoadingScreen(),
    );
  }
}
