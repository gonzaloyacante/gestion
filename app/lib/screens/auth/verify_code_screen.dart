import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import 'auth_screen_base.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String email;

  const VerifyCodeScreen({super.key, required this.email});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  final _codeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final auth = context.watch<AuthProvider>();

    return AuthScreenBase(
      title: 'Verificar Código',
      subtitle: 'Verificación de seguridad',
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                'Ingresa el código enviado a tu email:',
                style: theme.textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              CustomTextField(
                controller: _codeController,
                labelText: 'Código',
                keyboardType: TextInputType.number,
                maxLength: 6,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el código';
                  }
                  if (value.length != 6) {
                    return 'El código debe tener 6 dígitos';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              if (auth.isLoading)
                const CircularProgressIndicator()
              else
                CustomButton(text: 'Verificar Código', onPressed: _verifyCode),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _verifyCode() async {
    if (!_formKey.currentState!.validate()) return;

    final result = await context.read<AuthProvider>().verifyResetCode(
      widget.email,
      _codeController.text,
    );

    if (!mounted) return;

    if (result) {
      Navigator.pushReplacementNamed(
        context,
        '/reset-password',
        arguments: {'email': widget.email, 'code': _codeController.text},
      );
    }
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }
}
