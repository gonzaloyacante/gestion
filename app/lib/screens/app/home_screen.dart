import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../widgets/navigation_item.dart';
import 'dashboard/dashboard_page.dart';
import 'operations/operations_page.dart';
import 'inventory/inventory_page.dart';
import 'more/more_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  DateTime? _lastPressedAt;
  final List<NavigationItem> _pages = [
    NavigationItem(
      icon: Icons.dashboard_outlined,
      selectedIcon: Icons.dashboard,
      label: 'Inicio',
      builder: (context) => const DashboardPage(),
    ),
    NavigationItem(
      icon: Icons.point_of_sale_outlined,
      selectedIcon: Icons.point_of_sale,
      label: 'Operaciones',
      builder: (context) => const OperationsPage(),
    ),
    NavigationItem(
      icon: Icons.inventory_2_outlined,
      selectedIcon: Icons.inventory_2,
      label: 'Inventario',
      builder: (context) => const InventoryPage(),
    ),
    NavigationItem(
      icon: Icons.more_horiz_outlined,
      selectedIcon: Icons.more_horiz,
      label: 'Más',
      builder: (context) => const MorePage(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_lastPressedAt == null ||
            DateTime.now().difference(_lastPressedAt!) >
                const Duration(seconds: 2)) {
          _lastPressedAt = DateTime.now();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Presiona atrás otra vez para salir'),
              duration: Duration(seconds: 2),
            ),
          );
          return false;
        }
        await SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        body: _pages[_currentIndex].builder(context),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected:
              (index) => setState(() => _currentIndex = index),
          destinations:
              _pages
                  .map(
                    (page) => NavigationDestination(
                      icon: Icon(page.icon),
                      selectedIcon: Icon(page.selectedIcon),
                      label: page.label,
                    ),
                  )
                  .toList(),
        ),
      ),
    );
  }
}
