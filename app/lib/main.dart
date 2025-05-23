import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'app.dart';
import 'core/error/error_handler.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();

    // Inicializar servicios
    await _initializeServices();

    // Ejecutar app con capacidad de reinicio
    runApp(Phoenix(child: const App()));
  } catch (e, stackTrace) {
    ErrorHandler.handleFatalError(e, stackTrace);
    rethrow;
  }
}

Future<void> _initializeServices() async {
  // Inicializar manejo de errores
  ErrorHandler.initialize();

  // Forzar orientación vertical
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}
