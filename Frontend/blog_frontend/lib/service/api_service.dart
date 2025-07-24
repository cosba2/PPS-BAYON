import 'dart:convert';
import 'package:blog_frontend/models/posts_model.dart';
import 'package:blog_frontend/models/user_model.dart';
import 'package:blog_frontend/models/comments_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://pps-bayon.onrender.com/api';
  static const String apiKey = 'marcospps';

  // USERS
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

  // POSTS
  static Future<List<Post>> getPosts() async {
    final response = await http.get(
      Uri.parse('$baseUrl/posts'),
      headers: {'X-API-KEY': apiKey},
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);

      final List<dynamic> data = responseBody is List
          ? responseBody
          : responseBody['posts'] ?? [];

      return data.map((json) => Post.fromJson(json)).toList();

    } else {
      throw Exception('Error al obtener posts');
    }
  }

  static Future<bool> createPost(String title, String content, int userId) async {
    final url = Uri.parse('$baseUrl/posts');
    final response = await http.post(
    url,
      headers: {
        'Content-Type': 'application/json',
        'X-API-KEY': apiKey,
      },
      body: json.encode({
        'title': title,
        'content': content,
        'user_id': userId,
      }),
    );
    return response.statusCode == 201;
  }

  static Future<bool> updatePost(int id, String title, String content) async {
    final response = await http.put(
      Uri.parse('$baseUrl/posts/$id'),
      headers: {
        'Content-Type': 'application/json',
        'X-API-KEY': apiKey,
      },
      body: json.encode({
        'title': title,
        'content': content,
      }),
    );
    return response.statusCode == 200;
  }

  static Future<bool> deletePost(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/posts/$id'),
      headers: {
        'Content-Type': 'application/json',
        'X-API-KEY': apiKey,
      },
    );
    return response.statusCode == 200;
  }

  // COMMENTS
  static Future<List<Comment>> getComments() async {
    final response = await http.get(Uri.parse('$baseUrl/comments'),
        headers: {
          'Content-Type': 'application/json',
          'X-API-KEY': apiKey,
        });
    if (response.statusCode == 200) {
      final List<dynamic> body = json.decode(response.body);
      return body.map((json) => Comment.fromJson(json)).toList();
    } else {
      return [];
    }
  }

  static Future<bool> createComment(String content, int userId, int postId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/comments'),
      headers: {
        'Content-Type': 'application/json',
        'X-API-KEY': apiKey,
      },
      body: jsonEncode({
        'content': content,
        'user_id': userId,
        'post_id': postId,
      }),
    );
    return response.statusCode == 201;
  }

  static Future<bool> deleteComment(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/comments/$id'), headers: {
      'Content-Type': 'application/json',
      'X-API-KEY': apiKey,
    });
    return response.statusCode == 200;
  }

  static Future<List<Comment>> getCommentsByPostId(int postId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/comments?post_id=$postId'),
      headers: {'X-API-KEY': apiKey},
    );

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((e) => Comment.fromJson(e)).toList();
    } else {
      throw Exception('Error al obtener comentarios');
    }
  }


}
