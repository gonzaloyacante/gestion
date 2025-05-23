import 'package:flutter/foundation.dart';
import '../../services/auth_service.dart';

abstract class BaseAuthController with ChangeNotifier {
  final AuthService _authService;
  bool _isLoading = false;
  String? _errorMessage;

  BaseAuthController({AuthService? authService})
    : _authService = authService ?? AuthService();

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setError(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  Future<bool> handleAsync(Future<bool> Function() action) async {
    try {
      setLoading(true);
      setError(null);
      final result = await action();
      return result;
    } catch (e) {
      setError(e.toString());
      return false;
    } finally {
      setLoading(false);
    }
  }

  @protected
  AuthService get authService => _authService;
}
