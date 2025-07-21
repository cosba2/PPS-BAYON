import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:blog_frontend/models/user_model.dart';

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
      List<User> users = body.map((json) => User.fromJson(json)).toList();
      return users;
    } else {
      throw Exception('Error al cargar usuarios: ${response.body}');
    }
  }
}
