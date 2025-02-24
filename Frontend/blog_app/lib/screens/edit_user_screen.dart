import 'package:flutter/material.dart';
import 'package:blog_app/services/api_service.dart';

class EditUserScreen extends StatefulWidget {
  final String userId;
  final Map<String, dynamic> userData;

  EditUserScreen({required this.userId, required this.userData});

  @override
  _EditUserScreenState createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  final _formKey = GlobalKey<FormState>();
  final ApiService apiService = ApiService();
  late TextEditingController nameController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.userData?['name'] ?? '');
    emailController = TextEditingController(text: widget.userData?['email'] ?? '');
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  Future<void> _updateUser() async {
    if (_formKey.currentState!.validate()) {
      var userData = {
        'name': nameController.text,
        'email': emailController.text,
      };
      try {
        await apiService.updateUser(widget.userId, userData);
        Navigator.pop(context); // Regresar a la lista de usuarios
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al actualizar el usuario: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Editar Usuario')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un nombre';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateUser,
                child: Text('Actualizar Usuario'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
