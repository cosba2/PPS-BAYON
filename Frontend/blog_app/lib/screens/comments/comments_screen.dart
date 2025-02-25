import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import 'comment_detail_screen.dart';

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({super.key});

  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final ApiService apiService = ApiService();
  late Future<List<dynamic>> _futureComments;

  @override
  void initState() {
    super.initState();
    _loadComments();
  }

  void _loadComments() {
    setState(() {
      _futureComments = apiService.getAllComments();
    });
  }

Future<void> _deleteComment(String commentId) async {
  bool success = await apiService.deleteComment(commentId);
  if (success) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Comentario eliminado correctamente')),
    );
    _loadComments(); // Recargar la lista de comentarios
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error al eliminar el comentario')),
    );
  }
}

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Comentarios')),
      body: FutureBuilder<List<dynamic>>(
        future: _futureComments,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay comentarios disponibles.'));
          }

          var comments = snapshot.data!;
          return 
          ListView.builder(
            itemCount: comments.length,
            itemBuilder: (context, index) {
              var comment = comments[index];
              String commentId = comment['id_comment']?.toString() ?? 'Desconocido';
              String text = comment['content']?.toString() ?? 'Sin texto';
              String postId = comment['post_id']?.toString() ?? 'Desconocido';

              return ListTile(
                title: Text(text),
                subtitle: Text('Post ID: $postId'),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () async {
                    bool confirmDelete = await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Eliminar Comentario'),
                        content: Text('¿Estás seguro de que quieres eliminar este comentario?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: Text('Cancelar'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: Text('Eliminar', style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      ),
                    );

                    if (confirmDelete == true) {
                      _deleteComment(commentId);
                    }
                  },
                ),
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