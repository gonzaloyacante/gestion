import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class ErrorHandler {
  static void initialize() {
    FlutterError.onError = (details) {
      FlutterError.presentError(details);
      debugPrint('Error: ${details.exception}');
      debugPrint('Stack trace: ${details.stack}');
    };

    ErrorWidget.builder = (details) {
      return Material(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 60),
              const SizedBox(height: 16),
              const Text(
                'Ha ocurrido un error',
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              if (kDebugMode) ...[
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    details.exception.toString(),
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () {
                  debugPrint('Reiniciando app...');
                  Phoenix.rebirth(details.context! as BuildContext);
                },
                child: const Text('Reiniciar App'),
              ),
            ],
          ),
        ),
      );
    };
  }

  static void handleFatalError(dynamic error, [StackTrace? stackTrace]) {
    debugPrint('Error fatal: $error');
    if (stackTrace != null) {
      debugPrint('Stack trace: $stackTrace');
    }
  }
}
