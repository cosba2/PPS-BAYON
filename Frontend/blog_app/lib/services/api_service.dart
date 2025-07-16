import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ApiService {
  // Singleton instance
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  // Initialize API service
  static Future<void> initialize() async {
    await dotenv.load(fileName: ".env");
  }

  // Base URL from environment
  static String get baseUrl {
    final url = dotenv.env['API_BASE_URL'] ?? dotenv.env['DATABASE_URL'];
    if (url == null || url.isEmpty) {
      throw Exception('API_BASE_URL/DATABASE_URL no está configurado en .env');
    }
    return url;
  }

  // Authorization token
  static String _getAuthorizationToken() {
    final token = dotenv.env['API_KEY'];
    if (token == null || token.isEmpty) {
      throw Exception('API_KEY no está configurado en .env');
    }
    return token;
  }

  // Common headers
  static Map<String, String> get headers {
    return {
      'Authorization': _getAuthorizationToken(),
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (kDebugMode) 'X-Debug-Mode': 'true',
    };
  }

  // ==================== GENERIC METHODS ====================

  Future<dynamic> _request(
    String method,
    String endpoint, {
    Map<String, dynamic>? data,
    Map<String, String>? customHeaders,
  }) async {
    final uri = Uri.parse('$baseUrl/$endpoint');
    final requestHeaders = {...headers, ...?customHeaders};

    if (kDebugMode) {
      print('$method Request to: $uri');
      if (data != null) print('Request Body: $data');
    }

    try {
      http.Response response;
      switch (method) {
        case 'GET':
          response = await http.get(uri, headers: requestHeaders);
          break;
        case 'POST':
          response = await http.post(
            uri,
            headers: requestHeaders,
            body: jsonEncode(data),
          );
          break;
        case 'PUT':
          response = await http.put(
            uri,
            headers: requestHeaders,
            body: jsonEncode(data),
          );
          break;
        case 'DELETE':
          response = await http.delete(uri, headers: requestHeaders);
          break;
        default:
          throw Exception('Método HTTP no soportado: $method');
      }

      return _handleResponse(response);
    } catch (e) {
      if (kDebugMode) print('Error en la solicitud: $e');
      throw ApiException(
        statusCode: 500,
        message: 'Error de conexión: ${e.toString()}',
      );
    }
  }

  // ==================== USER METHODS ====================

  Future<List<dynamic>> getUsers() async {
    final response = await _request('GET', 'users');
    return response as List<dynamic>;
  }

  Future<dynamic> getUserById(int id) async {
    return _request('GET', 'users/$id');
  }

  Future<dynamic> createUser(Map<String, dynamic> user) async {
    return _request('POST', 'users', data: user);
  }

  Future<dynamic> updateUser(int id, Map<String, dynamic> user) async {
    return _request('PUT', 'users/$id', data: user);
  }

  Future<void> deleteUser(int id) async {
    await _request('DELETE', 'users/$id');
  }

  // ==================== POST METHODS ====================

  Future<List<dynamic>> getPosts() async {
    final response = await _request('GET', 'posts');
    return response as List<dynamic>;
  }

  Future<dynamic> getPostById(int id) async {
    return _request('GET', 'posts/$id');
  }

  Future<dynamic> createPost(Map<String, dynamic> post) async {
    return _request('POST', 'posts', data: post);
  }

  Future<dynamic> updatePost(int id, Map<String, dynamic> post) async {
    return _request('PUT', 'posts/$id', data: post);
  }

  Future<void> deletePost(int id) async {
    await _request('DELETE', 'posts/$id');
  }

  // ==================== COMMENT METHODS ====================

  Future<List<dynamic>> getComments() async {
    final response = await _request('GET', 'comments');
    return response as List<dynamic>;
  }

  Future<dynamic> getCommentById(int id) async {
    return _request('GET', 'comments/$id');
  }

  Future<dynamic> createComment(Map<String, dynamic> comment) async {
    return _request('POST', 'comments', data: comment);
  }

  Future<dynamic> updateComment(int id, Map<String, dynamic> comment) async {
    return _request('PUT', 'comments/$id', data: comment);
  }

  Future<void> deleteComment(int id) async {
    await _request('DELETE', 'comments/$id');
  }

  // ==================== RESPONSE HANDLING ====================

  dynamic _handleResponse(http.Response response) {
    if (kDebugMode) {
      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');
    }

    try {
      final responseData = response.body.isNotEmpty 
          ? jsonDecode(response.body) 
          : null;

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return responseData;
      } else {
        final errorMessage = responseData is Map 
            ? responseData['message'] ?? 'Error en la solicitud'
            : 'Error en la solicitud';
        
        throw ApiException(
          statusCode: response.statusCode,
          message: errorMessage,
          data: responseData,
        );
      }
    } catch (e) {
      throw ApiException(
        statusCode: response.statusCode,
        message: 'Error procesando la respuesta: ${e.toString()}',
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

  // Helper method to show error in UI
  String get userFriendlyMessage {
    switch (statusCode) {
      case 400:
        return 'Solicitud incorrecta: $message';
      case 401:
        return 'No autorizado. Por favor inicie sesión nuevamente.';
      case 403:
        return 'Acceso prohibido: $message';
      case 404:
        return 'Recurso no encontrado: $message';
      case 500:
        return 'Error del servidor: $message';
      default:
        return message;
    }
  }
}