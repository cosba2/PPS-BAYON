import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  final String baseUrl = dotenv.env['API_URL']!;
  final String apiKey = dotenv.env['API_KEY']!;

  Map<String, String> get headers => {
    'Content-Type': 'application/json',
    'X-API-KEY': apiKey,
  };

  Future<List<dynamic>> getPosts() async {
    final response = await http.get(Uri.parse('$baseUrl/posts'), headers: headers);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al obtener publicaciones');
    }
  }

  Future<void> createPost(String title, String content, int userId) async {
    final body = jsonEncode({
      "title": title,
      "content": content,
      "user_id": userId
    });

    final response = await http.post(
      Uri.parse('$baseUrl/posts'),
      headers: headers,
      body: body,
    );

    if (response.statusCode != 201) {
      throw Exception('Error al crear publicación');
    }
  }

  // Agregamos funciones similares para users y comments
}
