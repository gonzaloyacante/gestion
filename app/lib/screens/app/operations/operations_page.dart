import 'package:flutter/material.dart';
import '../app_screen_base.dart';

class OperationsPage extends StatelessWidget {
  const OperationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScreenBase(
      title: 'Operaciones',
      showBackButton: false,
      children: [Text('Operaciones')],
    );
  }
}
