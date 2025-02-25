import 'package:flutter/material.dart';
import '../../services/api_service.dart';

class CreateCommentScreen extends StatefulWidget {
  const CreateCommentScreen({super.key});

  @override
  _CreateCommentScreenState createState() => _CreateCommentScreenState();
}

class _CreateCommentScreenState extends State<CreateCommentScreen> {
  final _formKey = GlobalKey<FormState>();
  final ApiService apiService = ApiService();
  final TextEditingController textController = TextEditingController();
  final TextEditingController postIdController = TextEditingController();
  final TextEditingController userIdController = TextEditingController(); // Nuevo campo para user_id

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
              TextFormField(
                controller: userIdController,
                decoration: InputDecoration(labelText: 'User ID'), // Campo para user_id
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un User ID';
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
                      'user_id': int.parse(userIdController.text), // Incluir user_id
                    };

                    bool success = await apiService.createComment(commentData);
                    if (success) {
                      // Devolver `true` para indicar que se creó un comentario
                      Navigator.pop(context, true);
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