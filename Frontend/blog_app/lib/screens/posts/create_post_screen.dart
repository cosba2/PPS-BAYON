import 'package:flutter/material.dart';
import 'package:blog_app/services/api_service.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _formKey = GlobalKey<FormState>();
  final ApiService apiService = ApiService();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final TextEditingController userIdController = TextEditingController();

  Future<void> _createPost() async {
    if (_formKey.currentState!.validate()) {
      try {
        await apiService.createPost(
          titleController.text,
          contentController.text,
          int.parse(userIdController.text),
        );
        Navigator.pop(context, true);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al crear el post: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Crear Post')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Título'),
                validator: (value) => value!.isEmpty ? 'Ingresa un título' : null,
              ),
              TextFormField(
                controller: contentController,
                decoration: InputDecoration(labelText: 'Contenido'),
                validator: (value) => value!.isEmpty ? 'Ingresa contenido' : null,
              ),
              TextFormField(
                controller: userIdController,
                decoration: InputDecoration(labelText: 'ID del usuario'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Ingresa un ID de usuario' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _createPost,
                child: Text('Crear Post'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
