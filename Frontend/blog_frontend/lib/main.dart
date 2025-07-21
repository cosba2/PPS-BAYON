import 'package:flutter/material.dart';
import 'screens/user_list_screen.dart'; // Importamos la pantalla que creaste

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter con Flask',
      home: UserListScreen(), // Mostramos directamente la lista de usuarios
    );
  }
}
