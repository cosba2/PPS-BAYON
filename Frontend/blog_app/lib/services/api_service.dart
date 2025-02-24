import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String baseUrl = "https://pps-bayon.onrender.com/api";

  // Obtener todos los usuarios
  Future<dynamic> getUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/users'));
    return jsonDecode(response.body);
  }

  // Obtener un usuario por ID
  Future<dynamic> getUserById(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$id'));
    return jsonDecode(response.body);
  }

  // Crear un nuevo usuario
  Future<dynamic> createUser(Map<String, dynamic> userData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(userData),
    );
    return jsonDecode(response.body);
  }

  // Actualizar un usuario existente
  Future<dynamic> updateUser(String id, Map<String, dynamic> userData) async {
    final response = await http.put(
      Uri.parse('$baseUrl/users/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(userData),
    );
    return jsonDecode(response.body);
  }

  // Eliminar un usuario
  Future<dynamic> deleteUser(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/users/$id'));
    return jsonDecode(response.body);
  }

  // Obtener todos los posts
  Future<dynamic> getPosts() async {
    final response = await http.get(Uri.parse('$baseUrl/posts'));
    return jsonDecode(response.body);
  }

  // Crear un nuevo post
  Future<dynamic> createPost(Map<String, dynamic> postData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/posts'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(postData),
    );
    return jsonDecode(response.body);
  }

  // Añadir más métodos como PUT, DELETE para posts si es necesario
}
