import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://pps-bayon.onrender.com/api";

  // Updated headers to dynamically retrieve the authorization token
  static Map<String, String> get headers {
    final String token = _getAuthorizationToken(); // Retrieve token securely
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  // Method to securely retrieve the authorization token
  static String _getAuthorizationToken() {
    // Replace this with actual secure token retrieval logic
    return 'secure_token_example';
  }

  // ==================== MÉTODO GENÉRICO ====================

  Future<dynamic> _customGet(String url) async {
    final uri = Uri.parse(url);
    final response = await http.get(uri, headers: headers);
    return _handleResponse(response);
  }

  // ==================== USERS ====================

  Future<List<dynamic>> getUsers() async {
    final response = await _customGet('$baseUrl/users');
    return response as List<dynamic>;
  }

  Future<dynamic> getUserById(int id) async {
    return _customGet('$baseUrl/users/$id');
  }

  Future<dynamic> createUser(Map<String, dynamic> user) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users'),
      headers: headers,
      body: jsonEncode(user),
    );
    return _handleResponse(response);
  }

  Future<dynamic> updateUser(int id, Map<String, dynamic> user) async {
    final response = await http.put(
      Uri.parse('$baseUrl/users/$id'),
      headers: headers,
      body: jsonEncode(user),
    );
    return _handleResponse(response);
  }

  Future<void> deleteUser(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/users/$id'),
      headers: headers,
    );
    _handleResponse(response);
  }

  // ==================== POSTS ====================

  Future<List<dynamic>> getPosts() async {
    final response = await _customGet('$baseUrl/posts');
    return response as List<dynamic>;
  }

  Future<dynamic> getPostById(int id) async {
    return _customGet('$baseUrl/posts/$id');
  }

  Future<dynamic> createPost(Map<String, dynamic> post) async {
    final response = await http.post(
      Uri.parse('$baseUrl/posts'),
      headers: headers,
      body: jsonEncode(post),
    );
    return _handleResponse(response);
  }

  Future<dynamic> updatePost(int id, Map<String, dynamic> post) async {
    final response = await http.put(
      Uri.parse('$baseUrl/posts/$id'),
      headers: headers,
      body: jsonEncode(post),
    );
    return _handleResponse(response);
  }

  Future<void> deletePost(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/posts/$id'),
      headers: headers,
    );
    _handleResponse(response);
  }

  // ==================== COMMENTS ====================

  Future<List<dynamic>> getComments() async {
    final response = await _customGet('$baseUrl/comments');
    return response as List<dynamic>;
  }

  Future<dynamic> getCommentById(int id) async {
    return _customGet('$baseUrl/comments/$id');
  }

  Future<dynamic> createComment(Map<String, dynamic> comment) async {
    final response = await http.post(
      Uri.parse('$baseUrl/comments'),
      headers: headers,
      body: jsonEncode(comment),
    );
    return _handleResponse(response);
  }

  Future<dynamic> updateComment(int id, Map<String, dynamic> comment) async {
    final response = await http.put(
      Uri.parse('$baseUrl/comments/$id'),
      headers: headers,
      body: jsonEncode(comment),
    );
    return _handleResponse(response);
  }

  Future<void> deleteComment(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/comments/$id'),
      headers: headers,
    );
    _handleResponse(response);
  }

  // ==================== HANDLER ====================

  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response.body.isNotEmpty ? jsonDecode(response.body) : null;
    } else {
      throw Exception('Error: ${response.statusCode} - ${response.body}');
    }
  }
}
