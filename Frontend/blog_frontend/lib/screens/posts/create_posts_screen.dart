import 'package:flutter/material.dart';
import 'package:blog_frontend/service/api_service.dart';
import 'package:blog_frontend/models/posts_model.dart';
import 'package:blog_frontend/models/user_model.dart';


class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  int? _selectedUserId;
  late Future<List<User>> _usersFuture;

  @override
  void initState() {
    super.initState();
    _usersFuture = ApiService.getUsers();
  }

  void _createPost() async {
    if (_formKey.currentState!.validate() && _selectedUserId != null) {
      final newPost = Post(
        id: 0,
        title: _titleController.text,
        content: _contentController.text,
        userId: _selectedUserId!,
        author: '',
      );

      final success = await ApiService.createPost(newPost.title, newPost.content, newPost.userId!);
      if (success) {
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al crear el post')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crear Post')),
      body: FutureBuilder<List<User>>(
        future: _usersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
          if (snapshot.hasError) return const Center(child: Text('Error al cargar usuarios'));

          final users = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(labelText: 'Título'),
                    validator: (value) => value!.isEmpty ? 'Ingresa un título' : null,
                  ),
                  TextFormField(
                    controller: _contentController,
                    decoration: const InputDecoration(labelText: 'Contenido'),
                    validator: (value) => value!.isEmpty ? 'Ingresa el contenido' : null,
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<int>(
                    decoration: const InputDecoration(labelText: 'Seleccionar Usuario'),
                    value: _selectedUserId,
                    items: users.map((user) {
                      return DropdownMenuItem<int>(
                        value: user.id,
                        child: Text(user.username),
                      );
                    }).toList(),
                    onChanged: (value) => setState(() => _selectedUserId = value),
                    validator: (value) => value == null ? 'Selecciona un usuario' : null,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _createPost,
                    child: const Text('Crear'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}