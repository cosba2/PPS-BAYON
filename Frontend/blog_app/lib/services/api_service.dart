import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  static const String baseUrl = "https://pps-bayon.onrender.com/api";
  
  static Future<String> _getApiKey() async {
    return dotenv.env['API_KEY'] ?? 
      (throw Exception("API_KEY no encontrada en variables de entorno"));
  }

  static Future<Map<String, String>> getHeaders() async {
    return {
      'X-API-KEY': await _getApiKey(),
      'Content-Type': 'application/json',
    };
  }

  // ==================== MÉTODO GENÉRICO ====================
 static Future<dynamic> _handleRequest(Future<http.Response> request) async {
    try {
      final response = await request;
      return _handleResponse(response);
    } catch (e) {
      throw Exception('Error en la petición: $e');
    }
  }

  static dynamic _handleResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return response.body.isNotEmpty ? jsonDecode(response.body) : null;
      case 400:
        throw Exception('Bad Request: ${response.body}');
      case 401:
      case 403:
        throw Exception('Acceso no autorizado: ${response.body}');
      case 404:
        throw Exception('Recurso no encontrado');
      case 500:
      default:
        throw Exception(
          'Error en el servidor (${response.statusCode}): ${response.body}'
        );
    }
  }

  // ==================== USERS ====================
  static Future<List<dynamic>> getUsers() async {
    final response = await http.get(
      Uri.parse('$baseUrl/users'),
      headers: await getHeaders(),
    );
    return _handleResponse(response) as List<dynamic>;
  }

  static Future<dynamic> getUserById(int id) async {
    return _handleRequest(
      http.get(
        Uri.parse('$baseUrl/users/$id'),
        headers: await getHeaders(),
      )
    );
  }

  static Future<dynamic> createUser(Map<String, dynamic> user) async {
    return _handleRequest(
      http.post(
        Uri.parse('$baseUrl/users'),
        headers: await getHeaders(),
        body: jsonEncode(user),
      )
    );
  }

  static Future<dynamic> updateUser(int id, Map<String, dynamic> user) async {
    return _handleRequest(
      http.put(
        Uri.parse('$baseUrl/users/$id'),
        headers: await getHeaders(),
        body: jsonEncode(user),
      )
    );
  }

  static Future<void> deleteUser(int id) async {
    await _handleRequest(
      http.delete(
        Uri.parse('$baseUrl/users/$id'),
        headers: await getHeaders(),
      )
    );
  }

  // ==================== POSTS ====================
  static Future<List<dynamic>> getPosts() async {
    final response = await http.get(
      Uri.parse('$baseUrl/posts'),
      headers: await getHeaders(),
    );
    return _handleResponse(response) as List<dynamic>;
  }

  static Future<dynamic> getPostById(int id) async {
    return _handleRequest(
      http.get(
        Uri.parse('$baseUrl/posts/$id'),
        headers: await getHeaders(),
      )
    );
  }

  static Future<dynamic> createPost(Map<String, dynamic> post) async {
    return _handleRequest(
      http.post(
        Uri.parse('$baseUrl/posts'),
        headers: await getHeaders(),
        body: jsonEncode(post),
      )
    );
  }

  static Future<dynamic> updatePost(int id, Map<String, dynamic> post) async {
    return _handleRequest(
      http.put(
        Uri.parse('$baseUrl/posts/$id'),
        headers: await getHeaders(),
        body: jsonEncode(post),
      )
    );
  }

  static Future<void> deletePost(int id) async {
    await _handleRequest(
      http.delete(
        Uri.parse('$baseUrl/posts/$id'),
        headers: await getHeaders(),
      )
    );
  }

  // ==================== COMMENTS ====================
  static Future<List<dynamic>> getComments() async {
    final response = await http.get(
      Uri.parse('$baseUrl/comments'),
      headers: await getHeaders(),
    );
    return _handleResponse(response) as List<dynamic>;
  }

  static Future<dynamic> getCommentById(int id) async {
    return _handleRequest(
      http.get(
        Uri.parse('$baseUrl/comments/$id'),
        headers: await getHeaders(),
      )
    );
  }

  static Future<dynamic> createComment(Map<String, dynamic> comment) async {
    return _handleRequest(
      http.post(
        Uri.parse('$baseUrl/comments'),
        headers: await getHeaders(),
        body: jsonEncode(comment),
      )
    );
  }

  static Future<dynamic> updateComment(int id, Map<String, dynamic> comment) async {
    return _handleRequest(
      http.put(
        Uri.parse('$baseUrl/comments/$id'),
        headers: await getHeaders(),
        body: jsonEncode(comment),
      )
    );
  }

  static Future<void> deleteComment(int id) async {
    await _handleRequest(
      http.delete(
        Uri.parse('$baseUrl/comments/$id'),
        headers: await getHeaders(),
      )
    );
  }
}