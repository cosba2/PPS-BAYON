import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BLOG APP'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Botón para la sección de Usuarios
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/users');
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Text(
                'Usuarios',
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),

            // Botón para la sección de Posts
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/posts');
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Text(
                'Posts',
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),

            // Botón para la sección de Comentarios
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/comments');
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Text(
                'Comentarios',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}