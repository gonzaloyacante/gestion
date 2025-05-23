import 'package:flutter/material.dart';
import '../../providers/auth_provider.dart';
import '../../routes/app_routes.dart';
import 'auth_screen_base.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passCtrl = TextEditingController();
  bool _obscureText = true;

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

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
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
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final theme = Theme.of(context);

    return AuthScreenBase(
      title: 'Bienvenido',
      subtitle: 'Inicia sesión para continuar',
      bottomWidget: TextButton(
        onPressed: () => Navigator.pushNamed(context, AppRoutes.register),
        child: const Text('¿No tienes cuenta? Regístrate'),
      ),
      children: [
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
                textInputAction: TextInputAction.done,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed:
                      () => Navigator.pushNamed(
                        context,
                        AppRoutes.forgotPassword,
                      ),
                  child: const Text('¿Olvidaste tu contraseña?'),
                ),
              ),
              const SizedBox(height: 24),
              if (auth.isLoading)
                const Center(child: CircularProgressIndicator())
              else ...[
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final success = await auth.login(
                        _emailCtrl.text.trim(),
                        _passCtrl.text.trim(),
                      );
                      if (success && context.mounted) {
                        Navigator.pushReplacementNamed(context, AppRoutes.home);
                      } else if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Error al iniciar sesión'),
                            backgroundColor: theme.colorScheme.error,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                    }
                  },
                  child: const Text('INGRESAR'),
                ),
                // const SizedBox(height: 16),
                // const _OrDivider(),
                // const SizedBox(height: 16),
                // OutlinedButton.icon(
                //   onPressed: null, // Deshabilitado
                //   icon: Image.network(
                //     'https://www.google.com/favicon.ico',
                //     height: 24,
                //   ),
                //   label: const Text('Continuar con Google'),
                //   style: OutlinedButton.styleFrom(
                //     padding: const EdgeInsets.all(16),
                //     disabledForegroundColor:
                //         Colors
                //             .grey, // Color del texto cuando está deshabilitado
                //     backgroundColor:
                //         Colors
                //             .grey[100], // Color de fondo cuando está deshabilitado
                //   ),
                // ),
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
  // }
// }
