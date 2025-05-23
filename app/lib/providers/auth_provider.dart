import 'package:flutter/foundation.dart';
import '../services/auth_service.dart';
import '../models/user_model.dart';
import '../services/storage_service.dart';

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthProvider with ChangeNotifier {
  final AuthService _authService;
  final StorageService? _storage;

  AuthStatus _status = AuthStatus.checking;
  UserModel? _user;
  String? _token;
  bool _isLoading = false;
  String? _errorMessage;

  AuthProvider({StorageService? storage, AuthService? authService})
    : _storage = storage,
      _authService = authService ?? AuthService();

  // Getters
  AuthStatus get status => _status;
  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _status == AuthStatus.authenticated;

  // Método auxiliar para manejar estados
  Future<bool> _handleRequest(Future<dynamic> Function() request) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      await request();

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  // Autenticación
  Future<bool> login(String email, String password) async {
    return _handleRequest(() async {
      final response = await _authService.login(email, password);
      await _handleAuthResponse(response);
    });
  }

  Future<bool> register(String name, String email, String password) async {
    return _handleRequest(() async {
      final response = await _authService.register(name, email, password);
      await _handleAuthResponse(response);
    });
  }

  Future<void> _handleAuthResponse(Map<String, dynamic> response) async {
    _token = response['token'];
    _user = UserModel.fromJson(response['user']);
    _status = AuthStatus.authenticated;

    if (_storage != null) {
      await _storage.saveToken(_token!);
      await _storage.saveUser(_user!.toJson());
    }
  }

  // Verificación de sesión
  Future<void> checkAuthStatus() async {
    try {
      final token = _storage?.getToken();
      if (token == null) {
        _status = AuthStatus.notAuthenticated;
        notifyListeners();
        return;
      }

      final response = await _authService.verifyToken(token);
      _user = UserModel.fromJson(response['user']);
      _token = token;
      _status = AuthStatus.authenticated;
    } catch (e) {
      await logout();
    }
    notifyListeners();
  }

  // Recuperación de contraseña
  Future<bool> forgotPassword(String email) async {
    return _handleRequest(() => _authService.forgotPassword(email));
  }

  Future<bool> verifyResetCode(String email, String code) async {
    return _handleRequest(() => _authService.verifyResetCode(email, code));
  }

  Future<bool> resetPassword(
    String email,
    String code,
    String newPassword,
  ) async {
    return _handleRequest(
      () => _authService.resetPassword(email, code, newPassword),
    );
  }

  // Cierre de sesión
  Future<void> logout() async {
    try {
      if (_storage != null) {
        await _storage.deleteToken();
        await _storage.deleteUser();
      }
      _token = null;
      _user = null;
      _status = AuthStatus.notAuthenticated;
    } finally {
      notifyListeners();
    }
  }
}
