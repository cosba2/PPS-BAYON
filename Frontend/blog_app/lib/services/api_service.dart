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

//USERS--------------------------------------------------------------------------------

  Future<dynamic> getUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/users'));
    return _handleResponse(response);
  }

  Future<dynamic> getUserById(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$id'));
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> createUser(Map<String, dynamic> userData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(userData),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body); // Devuelve el JSON con el ID
    } else {
      throw Exception('Error al crear el usuario');
    }
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

// COMMENTS--------------------------------------------------------------------------------

  Future<List<dynamic>> getAllComments() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/comments'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data ?? [];
      } else {
        throw Exception('Error al obtener comentarios');
      }
    } catch (e) {
      print('Error en getAllComments: $e');
      return [];
    }
  }

  Future<Map<String, dynamic>> getCommentById(String commentId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/comments/$commentId'));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        return data ?? {};
      } else {
        throw Exception('Error al obtener el comentario');
      }
    } catch (e) {
      print('Error en getCommentById: $e');
      return {};
    }
  }

  Future<bool> createComment(Map<String, dynamic> commentData) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/comments'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(commentData),
      );

      if (response.statusCode == 201) {
        return true; // Se creó correctamente
      } else {
        print('Error al crear el comentario: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error en createComment: $e');
      return false;
    }
  }

  Future<bool> updateComment(String commentId, Map<String, dynamic> updatedData) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/comments/$commentId'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(updatedData),
      );

      if (response.statusCode == 200) {
        return true; // Se actualizó correctamente
      } else {
        print('Error al actualizar el comentario: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error en updateComment: $e');
      return false;
    }
  }

  Future<bool> deleteComment(String commentId) async {
    try {
      if (commentId == 'Desconocido') {
        throw Exception('ID de comentario no válido');
      }

      final response = await http.delete(
        Uri.parse('$baseUrl/comments/$commentId'),
      );

      if (response.statusCode == 200) {
        return true; // Comentario eliminado correctamente
      } else {
        print('Error al eliminar el comentario: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error en deleteComment: $e');
      return false;
    }
  }

// POSTS--------------------------------------------------------------------------------

 // Obtener todos los posts
  Future<List<dynamic>> getPosts() async {
    final response = await http.get(Uri.parse('$baseUrl/posts'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al obtener los posts');
    }
  }

  // Crear un nuevo post
  Future<void> createPost(String title, String content, int userId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/posts'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "title": title,
        "content": content,
        "user_id": userId,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Error al crear el post');
    }
  }

  // Actualizar un post
  Future<void> updatePost(int postId, String title, String content) async {
    final response = await http.put(
      Uri.parse('$baseUrl/posts/$postId'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "title": title,
        "content": content,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al actualizar el post');
    }
  }

  // Eliminar un post
  Future<void> deletePost(int postId) async {
    final response = await http.delete(Uri.parse('$baseUrl/posts/$postId'));

    if (response.statusCode != 200) {
      throw Exception('Error al eliminar el post');
    }
  }
}