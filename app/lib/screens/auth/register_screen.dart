import 'package:flutter/material.dart';
import '../../providers/auth_provider.dart';
import '../../routes/app_routes.dart';
import '../../widgets/custom_snackbar.dart';
import 'auth_screen_base.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmPassCtrl = TextEditingController();
  bool _obscureText = true;

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese su nombre';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese su email';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Por favor ingrese un email válido';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese su contraseña';
    }
    if (value.length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor confirme su contraseña';
    }
    if (value != _passCtrl.text) {
      return 'Las contraseñas no coinciden';
    }
    return null;
  }

  // Future<void> _handleGoogleSignIn(BuildContext context) async {
  //   final auth = context.read<AuthProvider>();
  //   try {
  //     final success = await auth.signInWithGoogle();
  //     if (success && mounted) {
  //       Navigator.pushReplacementNamed(context, AppRoutes.home);
  //     }
  //   } catch (e) {
  //     if (mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text(e.toString()),
  //           backgroundColor: Theme.of(context).colorScheme.error,
  //         ),
  //       );
  //     }
  //   }
  // }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _confirmPassCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    Theme.of(context);

    return AuthScreenBase(
      title: 'Crear cuenta',
      subtitle: 'Regístrate para comenzar',
      showBackButton: true,
      bottomWidget: TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('¿Ya tienes cuenta? Inicia sesión'),
      ),
      children: [
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameCtrl,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  prefixIcon: Icon(Icons.person_outline),
                ),
                textCapitalization: TextCapitalization.words,
                validator: _validateName,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailCtrl,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: _validateEmail,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passCtrl,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                    onPressed:
                        () => setState(() => _obscureText = !_obscureText),
                  ),
                ),
                obscureText: _obscureText,
                validator: _validatePassword,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _confirmPassCtrl,
                decoration: const InputDecoration(
                  labelText: 'Confirmar contraseña',
                  prefixIcon: Icon(Icons.lock_outline),
                ),
                obscureText: _obscureText,
                validator: _validateConfirmPassword,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 24),
              if (auth.isLoading)
                const Center(child: CircularProgressIndicator())
              else ...[
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final success = await auth.register(
                        _nameCtrl.text.trim(),
                        _emailCtrl.text.trim(),
                        _passCtrl.text.trim(),
                      );

                      if (success && context.mounted) {
                        CustomSnackBar.show(
                          context,
                          message: '¡Registro exitoso!',
                          type: SnackBarType.success,
                        );
                        Navigator.pushReplacementNamed(context, AppRoutes.home);
                      } else if (context.mounted && auth.errorMessage != null) {
                        CustomSnackBar.show(
                          context,
                          message: auth.errorMessage!,
                          type: SnackBarType.error,
                        );
                      }
                    }
                  },
                  child: const Text('REGISTRARSE'),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

// class _OrDivider extends StatelessWidget {
//   const _OrDivider();

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Row(
//       children: [
//         Expanded(
//           child: Divider(
//             color: theme.colorScheme.onBackground.withOpacity(0.3),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: Text(
//             'O',
//             style: theme.textTheme.bodyMedium?.copyWith(
//               color: theme.colorScheme.onBackground.withOpacity(0.7),
//             ),
//           ),
//         ),
//         Expanded(
//           child: Divider(
//             color: theme.colorScheme.onBackground.withOpacity(0.3),
//           ),
//         ),
//       ],
//     );
//   }
// }
