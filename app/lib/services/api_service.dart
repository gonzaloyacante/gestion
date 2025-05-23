import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/config/app_config.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();

  factory ApiService() => _instance;

  ApiService._internal();

  Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    final url = Uri.parse('${AppConfig.apiUrl}$endpoint');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error en la petición: ${response.statusCode}');
    }
  }

  // Puedes agregar GET, PUT, DELETE según necesidad
}
