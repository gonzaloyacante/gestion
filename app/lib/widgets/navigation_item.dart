import 'package:flutter/material.dart';

class NavigationItem {
  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final WidgetBuilder builder;

  const NavigationItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.builder,
  });
}
