import 'package:flutter/foundation.dart';

class HeadsetStatusNotifier extends ChangeNotifier {
  bool _isHeadsetConnected = false;

  bool get isHeadsetConnected => _isHeadsetConnected;

  void updateHeadsetStatus(bool isConnected) {
    _isHeadsetConnected = isConnected;
    notifyListeners();
  }
}
