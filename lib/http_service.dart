import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpService {
  static Future<Map<String, dynamic>?> loginN8n(String email, String password) async {
    final url = Uri.parse('http://10.20.22.6:5678/webhook/verificartoken');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print('Error de conexión: $e');
      return null;
    }
  }
}