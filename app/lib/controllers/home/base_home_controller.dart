import 'package:flutter/foundation.dart';

abstract class BaseHomeController with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  @protected
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  @protected
  void setError(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  @protected
  Future<T> handleAsync<T>(Future<T> Function() action) async {
    try {
      setLoading(true);
      setError(null);
      return await action();
    } catch (e) {
      setError(e.toString());
      rethrow;
    } finally {
      setLoading(false);
    }
  }
}
