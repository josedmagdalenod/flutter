import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpService {
  static const String _baseUrl = 'http://10.0.2.2:4000';

  static Future<Map<String, dynamic>?> loginN8n(String email, String password) async {
    final url = Uri.parse('http://10.20.22.6:5678/webhook/verificartoken');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        if (decoded is Map<String, dynamic>) {
          return decoded;
        }
        return {'data': decoded};
      }

      print('Error login: ${response.statusCode} - ${response.body}');
      return null;
    } catch (e) {
      print('Error de conexión en loginN8n: $e');
      return null;
    }
  }

  static Future<List<dynamic>> getMensajes() async {
    final url = Uri.parse('$_baseUrl/api/mensajes');

    try {
      final response = await http.get(
        url,
        headers: {'Accept': 'application/json'},
      ).timeout(const Duration(seconds: 10));

      print('GET ${url.toString()}');
      print('Status: ${response.statusCode}');
      print('Body: ${response.body}');

      if (response.statusCode != 200) {
        print('Error del servidor: ${response.statusCode} - ${response.body}');
        return [];
      }

      final body = response.body.trim();
      if (body.isEmpty) {
        print('Respuesta vacía');
        return [];
      }

      final decoded = jsonDecode(body);

      if (decoded is List) {
        print('Respuesta es un array con ${decoded.length} elementos');
        return decoded;
      }

      if (decoded is Map<String, dynamic>) {
        print('Respuesta es un objeto con claves: ${decoded.keys.toList()}');

        final candidates = <dynamic>[
          decoded['data'],
          decoded['mensajes'],
          decoded['result'],
          decoded['items'],
          decoded['chats'],
          decoded['messages'],
        ];

        for (final candidate in candidates) {
          if (candidate is List) {
            print('Se encontró lista en: ${candidate.runtimeType}');
            return candidate;
          }

          if (candidate is Map<String, dynamic>) {
            return [candidate];
          }
        }

        return [decoded];
      }

      print('Formato de respuesta no soportado: ${decoded.runtimeType}');
      return [];
    } catch (e) {
      print('Error de conexión al obtener mensajes: $e');
      return [];
    }
  }
}