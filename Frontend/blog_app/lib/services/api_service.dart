import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ApiService {
  // Cargar variables de entorno desde el archivo .env
  static Future<void> initialize() async {
    await dotenv.load(fileName: ".env");
  }

  // Obtener la URL base desde variables de entorno
  static String get baseUrl {
    final url = dotenv.env['DATABASE_URL'];
    if (url == null || url.isEmpty) {
      throw Exception('DATABASE_URL no está configurado en .env');
    }
    return url;
  }

  // Obtener el token de autorización desde variables de entorno
  static String _getAuthorizationToken() {
    final token = dotenv.env['API_KEY'];
    if (token == null || token.isEmpty) {
      throw Exception('API_KEY no está configurado en .env');
    }
    return token;
  }

  // Headers comunes para todas las solicitudes
  static Map<String, String> get headers {
    return {
      'Authorization': _getAuthorizationToken(),
      'Content-Type': 'application/json',
      if (kDebugMode) 'X-Debug-Mode': 'true', // Header adicional para desarrollo
    };
  }

  // ==================== MÉTODOS GENÉRICOS ====================

  Future<dynamic> _customGet(String endpoint) async {
    final uri = Uri.parse('$baseUrl/$endpoint');
    if (kDebugMode) {
      print('GET Request to: $uri');
    }
    
    final response = await http.get(uri, headers: headers);
    return _handleResponse(response);
  }

  Future<dynamic> _customPost(String endpoint, Map<String, dynamic> data) async {
    final uri = Uri.parse('$baseUrl/$endpoint');
    if (kDebugMode) {
      print('POST Request to: $uri');
      print('Request Body: $data');
    }
    
    final response = await http.post(
      uri,
      headers: headers,
      body: jsonEncode(data),
    );
    return _handleResponse(response);
  }

  Future<dynamic> _customPut(String endpoint, Map<String, dynamic> data) async {
    final uri = Uri.parse('$baseUrl/$endpoint');
    if (kDebugMode) {
      print('PUT Request to: $uri');
      print('Request Body: $data');
    }
    
    final response = await http.put(
      uri,
      headers: headers,
      body: jsonEncode(data),
    );
    return _handleResponse(response);
  }

  Future<void> _customDelete(String endpoint) async {
    final uri = Uri.parse('$baseUrl/$endpoint');
    if (kDebugMode) {
      print('DELETE Request to: $uri');
    }
    
    final response = await http.delete(uri, headers: headers);
    _handleResponse(response);
  }

  // ==================== USERS ====================

  Future<List<dynamic>> getUsers() async {
    final response = await _customGet('users');
    return response as List<dynamic>;
  }

  Future<dynamic> getUserById(int id) async {
    return _customGet('users/$id');
  }

  Future<dynamic> createUser(Map<String, dynamic> user) async {
    return _customPost('users', user);
  }

  Future<dynamic> updateUser(int id, Map<String, dynamic> user) async {
    return _customPut('users/$id', user);
  }

  Future<void> deleteUser(int id) async {
    await _customDelete('users/$id');
  }

  // ==================== POSTS ====================

  Future<List<dynamic>> getPosts() async {
    final response = await _customGet('posts');
    return response as List<dynamic>;
  }

  Future<dynamic> getPostById(int id) async {
    return _customGet('posts/$id');
  }

  Future<dynamic> createPost(Map<String, dynamic> post) async {
    return _customPost('posts', post);
  }

  Future<dynamic> updatePost(int id, Map<String, dynamic> post) async {
    return _customPut('posts/$id', post);
  }

  Future<void> deletePost(int id) async {
    await _customDelete('posts/$id');
  }

  // ==================== COMMENTS ====================

  Future<List<dynamic>> getComments() async {
    final response = await _customGet('comments');
    return response as List<dynamic>;
  }

  Future<dynamic> getCommentById(int id) async {
    return _customGet('comments/$id');
  }

  Future<dynamic> createComment(Map<String, dynamic> comment) async {
    return _customPost('comments', comment);
  }

  Future<dynamic> updateComment(int id, Map<String, dynamic> comment) async {
    return _customPut('comments/$id', comment);
  }

  Future<void> deleteComment(int id) async {
    await _customDelete('comments/$id');
  }

  // ==================== MANEJO DE RESPUESTAS ====================

  dynamic _handleResponse(http.Response response) {
    if (kDebugMode) {
      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');
    }

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response.body.isNotEmpty ? jsonDecode(response.body) : null;
    } else {
      final errorData = response.body.isNotEmpty 
          ? jsonDecode(response.body) 
          : {'message': 'Error desconocido'};
      throw ApiException(
        statusCode: response.statusCode,
        message: errorData['message'] ?? 'Error en la solicitud',
        data: errorData,
      );
    }
  }
}

class ApiException implements Exception {
  final int statusCode;
  final String message;
  final dynamic data;

  ApiException({
    required this.statusCode,
    required this.message,
    this.data,
  });

  @override
  String toString() {
    return 'ApiException: $message (Status: $statusCode)';
  }
}