import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String baseUrl = "https://pps-bayon.onrender.com/api";

  Future<dynamic> _handleResponse(http.Response response) async {
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  Future<dynamic> getUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/users'));
    return _handleResponse(response);
  }

  Future<dynamic> getUserById(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$id'));
    return _handleResponse(response);
  }

  Future<dynamic> createUser(Map<String, dynamic> userData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(userData),
    );
    return _handleResponse(response);
  }

  Future<dynamic> updateUser(String id, Map<String, dynamic> userData) async {
    final response = await http.put(
      Uri.parse('$baseUrl/users/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(userData),
    );
    return _handleResponse(response);
  }

  Future<dynamic> deleteUser(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/users/$id'));
    return _handleResponse(response);
  }
}