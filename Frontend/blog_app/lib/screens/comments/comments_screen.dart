import 'package:flutter/material.dart';
import 'package:blog_app/services/api_service.dart';
import 'package:blog_app/screens/comments/comment_detail_screen.dart';

class CommentsScreen extends StatefulWidget {
  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Comentarios')),
      body: FutureBuilder<List<dynamic>>(
        future: apiService.getAllComments(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay comentarios disponibles.'));
          }

          var comments = snapshot.data!;
          return ListView.builder(
            itemCount: comments.length,
            itemBuilder: (context, index) {
              var comment = comments[index];

              // Evita valores nulos en los datos
              String commentId = comment['id']?.toString() ?? 'Desconocido';
              String text = comment['content']?.toString() ?? 'Sin texto';
              String postId = comment['post_id']?.toString() ?? 'Desconocido';

              return ListTile(
                title: Text(text),
                subtitle: Text('Post ID: $postId'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CommentDetailScreen(commentId: commentId),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
