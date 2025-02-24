import 'package:blog_app/screens/create_user_screen.dart';
import 'package:blog_app/screens/users_detail.dart';
import 'package:flutter/material.dart';
import 'package:blog_app/services/api_service.dart';

class UsersScreen extends StatelessWidget {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Usuarios')),
      body: FutureBuilder(
        future: apiService.getUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            var users = snapshot.data;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                var user = users[index];
                return ListTile(
                  title: Text(user['name'] ?? 'Nombre no disponible'),
                  subtitle: Text(user['email'] ?? 'Email no disponible'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            UserDetailScreen(userId: user['id'] ?? '0'),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateUserScreen(),
            ),
          ).then((_) {
            // Recargar la lista de usuarios después de crear uno nuevo
            // Puedes usar un StatefulWidget y llamar a setState aquí si es necesario
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
