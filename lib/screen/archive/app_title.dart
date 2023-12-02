import 'package:flutter/material.dart';

AppBar appTitle({required BuildContext context, bool backButton = false}) {
  return AppBar(
    flexibleSpace: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: <Color>[Colors.blue, Colors.black]),
      ),
    ),
    title: const FittedBox(
      fit: BoxFit.contain,
      child: Text(
        'Selaras',
      ),
    ),
  );
}
