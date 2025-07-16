import 'package:blog_app/screens/posts/posts_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'screens/comments/comments_screen.dart';
import 'screens/users/users_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env"); // Cargar variables de entorno
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blog App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/posts',
      routes: {
        '/users': (context) => const UsersScreen(),
        '/posts': (context) => const PostsScreen(),
        '/comments': (context) => const CommentsScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
