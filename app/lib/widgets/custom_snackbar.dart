import 'package:flutter/material.dart';

enum SnackBarType { success, error, info, warning }

class CustomSnackBar extends SnackBar {
  CustomSnackBar({
    required String message,
    SnackBarType type = SnackBarType.info,
    super.key,
  }) : super(
         content: Row(
           children: [
             Icon(_getIcon(type), color: Colors.white),
             const SizedBox(width: 12),
             Expanded(child: Text(message)),
           ],
         ),
         backgroundColor: _getColor(type),
         behavior: SnackBarBehavior.floating,
         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
       );

  static IconData _getIcon(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return Icons.check_circle_outline;
      case SnackBarType.error:
        return Icons.error_outline;
      case SnackBarType.warning:
        return Icons.warning_amber;
      case SnackBarType.info:
        return Icons.info_outline;
    }
  }

  static Color _getColor(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return Colors.green;
      case SnackBarType.error:
        return Colors.red;
      case SnackBarType.warning:
        return Colors.orange;
      case SnackBarType.info:
        return Colors.blue;
    }
  }

  static void show(
    BuildContext context, {
    required String message,
    required SnackBarType type,
  }) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(CustomSnackBar(message: message, type: type));
  }
}
