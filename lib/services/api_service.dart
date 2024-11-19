import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://desafioflutter-api.modelviewlabs.com';


  static Future<String> validatePassword(String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/validate'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'password': password}),
    );

    if (response.statusCode == 202) {
      final data = jsonDecode(response.body);
      return data['message']; 
    } else {
      throw Exception('Erro ao validar a senha');
    }
  }
}
