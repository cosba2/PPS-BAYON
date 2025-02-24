import 'package:blog_app/screens/users_screen.dart';
import 'package:blog_app/screens/create_user_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Flask App',
      home: UsersScreen(),
      routes: {
        '/users': (context) => UsersScreen(),
        '/createUser': (context) => CreateUserScreen(),
      },
    );
  }
}
