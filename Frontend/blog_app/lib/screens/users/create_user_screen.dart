import 'package:flutter/material.dart';
import '../../services/api_service.dart';

class CreateUserScreen extends StatefulWidget {
  const CreateUserScreen({super.key});

  @override
  _CreateUserScreenState createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  final _formKey = GlobalKey<FormState>();
  final ApiService apiService = ApiService();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  int? newUserId; // Variable para almacenar el ID del nuevo usuario

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Crear Usuario')),
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
              if (newUserId != null) // Mostrar el ID si está disponible
                Text('Usuario creado con ID: $newUserId'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    var userData = {
                      'username': nameController.text,
                      'email': emailController.text,
                    };
                    try {
                      var response = await apiService.createUser(userData);
                      setState(() {
                        newUserId = response['id']; // Asignar el ID del nuevo usuario
                      });
                      // Mostrar un mensaje de éxito
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Usuario creado con ID: $newUserId')),
                      );
                      // No navegar de vuelta inmediatamente, para que el usuario vea el ID
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error al crear el usuario: $e')),
                      );
                    }
                  }
                },
                child: Text('Crear Usuario'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}