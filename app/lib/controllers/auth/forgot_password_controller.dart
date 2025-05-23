import 'base_auth_controller.dart';
import '../../services/auth_service.dart';

class ForgotPasswordController extends BaseAuthController {
  String? _email;

  ForgotPasswordController({AuthService? authService})
    : super(authService: authService);

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'El email es requerido';
    }
    if (!value.contains('@')) {
      return 'Email inválido';
    }
    return null;
  }

  Future<bool> sendResetEmail(String email) async {
    return handleAsync(() async {
      _email = email;
      await authService.forgotPassword(email);
      return true;
    });
  }

  Future<bool> verifyCode(String code) async {
    return handleAsync(() async {
      if (_email == null) throw Exception('Email no definido');
      await authService.verifyResetCode(_email!, code);
      return true;
    });
  }

  Future<bool> resetPassword(String code, String newPassword) async {
    return handleAsync(() async {
      if (_email == null) throw Exception('Email no definido');
      await authService.resetPassword(_email!, code, newPassword);
      return true;
    });
  }
}
