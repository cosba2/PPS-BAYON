import 'package:flutter/material.dart';
import 'package:blog_app/services/api_service.dart';

class CreateCommentScreen extends StatefulWidget {
  @override
  _CreateCommentScreenState createState() => _CreateCommentScreenState();
}

class _CreateCommentScreenState extends State<CreateCommentScreen> {
  final _formKey = GlobalKey<FormState>();
  final ApiService apiService = ApiService();
  final TextEditingController textController = TextEditingController();
  final TextEditingController postIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Crear Comentario')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: textController,
                decoration: InputDecoration(labelText: 'Texto'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un texto';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: postIdController,
                decoration: InputDecoration(labelText: 'Post ID'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un Post ID';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    var commentData = {
                      'content': textController.text,
                      'post_id': postIdController.text,
                    };

                    bool success = await apiService.createComment(commentData);
                    if (success) {
                      Navigator.pop(context); // Regresar a la lista de comentarios
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error al crear el comentario')),
                      );
                    }
                  }
                },
                child: Text('Crear Comentario'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
