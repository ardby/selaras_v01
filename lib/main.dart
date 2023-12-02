import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/data_provider.dart';
import 'screen/loading_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => DataProvider(),
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
      // theme: ThemeData(
      //   visualDensity: VisualDensity.standard,
      // ),
      theme: themeData,
      home: LoadingScreen(),
    );
  }
}
