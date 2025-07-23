import 'package:blog_frontend/screens/create_user_screen.dart';
import 'package:flutter/material.dart';
import 'screens/user_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Usuarios',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CreateUserScreen(),
    );
  }
}
  