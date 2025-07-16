import 'package:flutter/material.dart';
import 'package:blog_app/models/post.dart';
import 'package:blog_app/services/api_service.dart';

class UpdatePostScreen extends StatefulWidget {
  final Post post;

  const UpdatePostScreen({super.key, required this.post});

  @override
  _UpdatePostScreenState createState() => _UpdatePostScreenState();
}

class _UpdatePostScreenState extends State<UpdatePostScreen> {
  late final _formKey = GlobalKey<FormState>();
  late final _titleController = TextEditingController(text: widget.post.title);
  late final _bodyController = TextEditingController(text: widget.post.body);
  final _apiService = ApiService();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSubmitting = true;
    });

    try {
      await _apiService.updatePost(widget.post.id, {
        'title': _titleController.text,
        'body': _bodyController.text,
      });

      Navigator.pop(context, true);
    } on ApiException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.message}')),
      );
    } finally {
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Título'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un título';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _bodyController,
                decoration: const InputDecoration(labelText: 'Contenido'),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa contenido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isSubmitting ? null : _submitForm,
                child: _isSubmitting
                    ? const CircularProgressIndicator()
                    : const Text('Actualizar Post'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}