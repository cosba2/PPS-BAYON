import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  final String baseUrl = dotenv.env['BASE_URL'] ?? '';

  // Headers con API Key
  Map<String, String> getHeaders() {
    return {
      'Content-Type': 'application/json',
      'X-API-KEY': 'marcospps',
    };
  }

  // Manejo de respuesta genérico
  Future<dynamic> _handleResponse(http.Response response) async {
    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
          'Error [${response.statusCode}]: ${response.reasonPhrase}');
    }
  }

  // ======================= USERS =======================

  Future<List<dynamic>> getUsers() async {
    final headers = await getHeaders();
    final response = await http.get(Uri.parse('$baseUrl/users'), headers: headers);
    return _handleResponse(response) as List<dynamic>;
  }

  Future<dynamic> getUserById(String id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/users/$id'),
      headers: getHeaders(),
    );
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> createUser(Map<String, dynamic> userData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users'),
      headers: getHeaders(),
      body: jsonEncode(userData),
    );
    return _handleResponse(response) as Map<String, dynamic>;
  }

  Future<dynamic> updateUser(String id, Map<String, dynamic> userData) async {
    final response = await http.put(
      Uri.parse('$baseUrl/users/$id'),
      headers: getHeaders(),
      body: jsonEncode(userData),
    );
    return _handleResponse(response);
  }

  Future<dynamic> deleteUser(String id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/users/$id'),
      headers: getHeaders(),
    );
    return _handleResponse(response);
  }

  // ======================= COMMENTS =======================

  Future<List<dynamic>> getAllComments() async {
    final response = await http.get(
      Uri.parse('$baseUrl/comments'),
      headers: getHeaders(),
    );
    return _handleResponse(response) as List<dynamic>;
  }

  Future<Map<String, dynamic>> getCommentById(String id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/comments/$id'),
      headers: getHeaders(),
    );
    return _handleResponse(response) as Map<String, dynamic>;
  }

  Future<bool> createComment(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/comments'),
      headers: getHeaders(),
      body: jsonEncode(data),
    );
    return response.statusCode == 201;
  }

  Future<bool> updateComment(String id, Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse('$baseUrl/comments/$id'),
      headers: getHeaders(),
      body: jsonEncode(data),
    );
    return response.statusCode == 200;
  }

  Future<bool> deleteComment(String id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/comments/$id'),
      headers: getHeaders(),
    );
    return response.statusCode == 200;
  }

  // ======================= POSTS =======================

  Future<List<dynamic>> getPosts() async {
    final response = await http.get(
      Uri.parse('$baseUrl/posts'),
      headers: getHeaders(),
    );
    return _handleResponse(response) as List<dynamic>;
  }

  Future<void> createPost(String title, String content, int userId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/posts'),
      headers: getHeaders(),
      body: jsonEncode({
        'title': title,
        'content': content,
        'user_id': userId,
      }),
    );
    if (response.statusCode != 201) {
      throw Exception('Error al crear el post');
    }
  }

  Future<void> updatePost(int id, String title, String content) async {
    final response = await http.put(
      Uri.parse('$baseUrl/posts/$id'),
      headers: getHeaders(),
      body: jsonEncode({
        'title': title,
        'content': content,
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Error al actualizar el post');
    }
  }

  Future<void> deletePost(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/posts/$id'),
      headers: getHeaders(),
    );
    if (response.statusCode != 200) {
      throw Exception('Error al eliminar el post');
    }
  }
}
