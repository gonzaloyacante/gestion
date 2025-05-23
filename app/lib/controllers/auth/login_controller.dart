import '../../services/auth_service.dart';
import '../../models/user_model.dart';
import 'base_auth_controller.dart';

class LoginController extends BaseAuthController {
  final AuthService _authService;

  LoginController({AuthService? authService})
    : _authService = authService ?? AuthService();

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese su email';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Por favor ingrese un email válido';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese su contraseña';
    }
    return null;
  }

  Future<UserModel?> login(String email, String password) async {
    try {
      setLoading(true);
      final response = await _authService.login(email, password);
      return UserModel.fromJson(response['user']);
    } catch (e) {
      setError(e.toString());
      return null;
    } finally {
      setLoading(false);
    }
  }
}
