import 'package:flutter/material.dart';
import 'package:blog_frontend/models/comments_model.dart';
import 'package:blog_frontend/service/api_service.dart';
import 'package:blog_frontend/models/user_model.dart';
import 'package:blog_frontend/models/posts_model.dart';

class CommentScreen extends StatefulWidget {
  final int postId;

  const CommentScreen({super.key, required this.postId});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  List<Comment> comments = [];
  List<User> users = [];
  List<Post> posts = [];

  final TextEditingController contentController = TextEditingController();
  int? selectedUserId;
  int? selectedPostId;

  @override
  void initState() {
    super.initState();
    fetchInitialData();
  }

  Future<void> fetchInitialData() async {
    final fetchedComments = await ApiService.getComments();
    final fetchedUsers = await ApiService.getUsers();
    final fetchedPosts = await ApiService.getPosts();
    setState(() {
      comments = fetchedComments.where((c) => c.postId == widget.postId).toList();
      users = fetchedUsers;
      posts = fetchedPosts;
      selectedPostId = widget.postId;
    });
  }

  Future<void> createComment() async {
    if (contentController.text.isEmpty || selectedUserId == null || selectedPostId == null) return;

    final success = await ApiService.createComment(
      contentController.text,
      selectedUserId!,
      selectedPostId!,
    );

    if (success) {
      contentController.clear();
      await fetchInitialData();
    }
  }

  Future<void> deleteComment(int id) async {
    await ApiService.deleteComment(id);
    await fetchInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Comentarios")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: contentController,
                decoration: const InputDecoration(labelText: 'Contenido del comentario'),
              ),
            ),
            DropdownButton<int>(
              hint: const Text("Seleccionar usuario"),
              value: selectedUserId,
              items: users.map((u) {
                return DropdownMenuItem<int>(
                  value: u.id,
                  child: Text(u.username),
                );
              }).toList(),
              onChanged: (val) => setState(() => selectedUserId = val),
            ),
            ElevatedButton(
              onPressed: createComment,
              child: const Text("Crear comentario"),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const Text("Comentarios recientes"),
            ...comments.map((c) {
              final user = users.firstWhere(
                (u) => u.id == c.userId,
                orElse: () => User(id: 0, username: "Desconocido", email: ""),
              );
              final post = posts.firstWhere(
                (p) => p.id == c.postId,
                orElse: () => Post(id: 0, title: "Post eliminado", content: "", userId: 0, author: 'Desconocido'),
              );
              return ListTile(
                title: Text(c.content),
                subtitle: Text("Usuario: ${user.username}, Post: ${post.title}"),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => deleteComment(c.id),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
