import 'package:flutter/material.dart';
import '../app_screen_base.dart';

class InventoryPage extends StatelessWidget {
  const InventoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScreenBase(
      title: 'Inventario',
      showBackButton: false,
      children: [Text('Inventario')],
    );
  }
}
