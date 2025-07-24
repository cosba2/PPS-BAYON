import 'package:flutter/material.dart';
import 'package:blog_frontend/models/posts_model.dart';
import 'package:blog_frontend/models/comments_model.dart';
import 'package:blog_frontend/models/user_model.dart';
import 'package:blog_frontend/service/api_service.dart';

class PostDetailScreen extends StatefulWidget {
  final Post post;

  const PostDetailScreen({super.key, required this.post});

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  List<Comment> comments = [];
  List<User> users = [];

  @override
  void initState() {
    super.initState();
    fetchComments();
  }

  Future<void> fetchComments() async {
    final allComments = await ApiService.getComments();
    final fetchedUsers = await ApiService.getUsers();
    setState(() {
      comments = allComments.where((c) => c.postId == widget.post.id).toList();
      users = fetchedUsers;
    });
  }

  Future<void> deleteComment(int id) async {
    await ApiService.deleteComment(id);
    await fetchComments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.post.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.post.content, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 24),
            const Text("Comentarios:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
              child: comments.isEmpty
                  ? const Text("No hay comentarios.")
                  : ListView.builder(
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        final c = comments[index];
                        final user = users.firstWhere(
                          (u) => u.id == c.userId,
                          orElse: () => User(id: 0, username: "Desconocido", email: ""),
                        );
                        return ListTile(
                          title: Text(c.content),
                          subtitle: Text("Por: ${user.username}"),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => deleteComment(c.id),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
