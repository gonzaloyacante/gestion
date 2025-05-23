import 'package:flutter/foundation.dart';

class HomeController with ChangeNotifier {
  int _currentIndex = 0;
  DateTime? _lastPressedAt;

  int get currentIndex => _currentIndex;
  DateTime? get lastPressedAt => _lastPressedAt;

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void updateLastPressed() {
    _lastPressedAt = DateTime.now();
    notifyListeners();
  }

  bool shouldExitApp() {
    if (_lastPressedAt == null ||
        DateTime.now().difference(_lastPressedAt!) >
            const Duration(seconds: 2)) {
      updateLastPressed();
      return false;
    }
    return true;
  }
}
