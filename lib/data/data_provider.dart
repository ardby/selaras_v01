import 'package:flutter/foundation.dart';

class DataProvider extends ChangeNotifier {
  late List<dynamic> _appData = [];
  List<dynamic> get appData => _appData;

  void updateData(List<dynamic> newData) {
    _appData = newData;
    notifyListeners();
  }
}
