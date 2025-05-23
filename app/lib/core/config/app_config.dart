import 'dart:io' show Platform;

class AppConfig {
  static String get apiUrl {
    // En Android el emulador necesita 10.0.2.2 para acceder al localhost
    // En iOS el emulador necesita localhost
    // En web usamos localhost
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:5000/api';
    }
    return 'http://localhost:5000/api';
  }
}
