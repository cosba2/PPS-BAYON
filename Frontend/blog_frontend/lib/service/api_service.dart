import 'dart:convert';
import 'package:blog_frontend/models/user_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://pps-bayon.onrender.com/api';
  static const String apiKey = 'marcospps';

  static Future<List<User>> getUsers() async {
    final response = await http.get(
      Uri.parse('$baseUrl/users'),
      headers: {
        'Content-Type': 'application/json',
        'X-API-KEY': apiKey,
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener usuarios');
    }
  }

  static Future<bool> createUser(String username, String email) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users'),
      headers: {
        'Content-Type': 'application/json',
        'X-API-KEY': apiKey,
      },
      body: json.encode({
        'username': username,
        'email': email,
      }),
    );

    return response.statusCode == 201;
  }

    static Future<bool> updateUser(int id, String username, String email) async {
    final response = await http.put(
      Uri.parse('$baseUrl/users/$id'),
      headers: {
        'Content-Type': 'application/json',
        'X-API-KEY': apiKey,
      },
      body: json.encode({
        'username': username,
        'email': email,
      }),
    );

    return response.statusCode == 200;
  }

  static Future<bool> deleteUser(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/users/$id'),
      headers: {
        'X-API-KEY': apiKey,
      },
    );

    return response.statusCode == 200;
  }
}
