import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class QuickAccessItem {
  final IconData icon;
  final String title;
  final Color color;
  final String route;

  QuickAccessItem({
    required this.icon,
    required this.title,
    required this.color,
    required this.route,
  });
}

class HomeProvider with ChangeNotifier {
  bool _isLoading = false;
  List<QuickAccessItem> _quickAccessItems = [];

  bool get isLoading => _isLoading;
  List<QuickAccessItem> get quickAccessItems => _quickAccessItems;

  Future<void> loadQuickAccessItems() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Simular carga de datos
      await Future.delayed(const Duration(milliseconds: 500));

      _quickAccessItems = [
        QuickAccessItem(
          icon: Icons.inventory_2_outlined,
          title: 'Inventario',
          color: Colors.blue,
          route: '/inventory',
        ),
        QuickAccessItem(
          icon: Icons.people_outline,
          title: 'Clientes',
          color: Colors.green,
          route: '/clients',
        ),
        QuickAccessItem(
          icon: Icons.point_of_sale_outlined,
          title: 'Ventas',
          color: Colors.orange,
          route: '/sales',
        ),
        QuickAccessItem(
          icon: Icons.shopping_cart_outlined,
          title: 'Compras',
          color: Colors.purple,
          route: '/purchases',
        ),
        QuickAccessItem(
          icon: Icons.bar_chart_outlined,
          title: 'Estadísticas',
          color: Colors.red,
          route: '/statistics',
        ),
        QuickAccessItem(
          icon: Icons.settings_outlined,
          title: 'Configuración',
          color: Colors.grey,
          route: '/settings',
        ),
      ];
    } catch (e) {
      debugPrint('Error cargando items: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
