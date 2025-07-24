import 'package:flutter/material.dart';
import 'package:blog_frontend/screens/users/user_list_screen.dart';
import 'package:blog_frontend/screens/posts/post_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog App'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildNavButton(context, 'Usuarios', UserListScreen()),
            const SizedBox(height: 20),
            _buildNavButton(context, 'Publicaciones', PostListScreen()),
          ],
        ),
      ),
    );
  }

  Widget _buildNavButton(BuildContext context, String label, Widget destination) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        ),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
        ),
        child: Text(label, style: const TextStyle(fontSize: 18)),
      ),
    );
  }
}
