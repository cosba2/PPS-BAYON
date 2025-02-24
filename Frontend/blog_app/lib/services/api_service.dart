import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "https://pps-bayon.onrender.com/api"; // Cambiar si se despliega

  // Obtener publicaciones
  Future<List<dynamic>> getPosts() async {
    final response = await http.get(Uri.parse('$baseUrl/posts'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al obtener publicaciones');
    }
  }

  // Crear una publicación
  Future<void> createPost(String title, String content, int userId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/posts'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"title": title, "content": content, "user_id": userId}),
    );

    if (response.statusCode != 201) {
      throw Exception('Error al crear publicación');
    }
  }
}
