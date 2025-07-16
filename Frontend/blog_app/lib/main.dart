import 'package:blog_app/models/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:blog_app/screens/home_screen.dart';
// import 'package:blog_app/screens/users/users_screen.dart';
import 'package:blog_app/screens/posts/posts_screen.dart';
// import 'package:blog_app/screens/comments/comments_screen.dart';
import 'package:blog_app/screens/posts/create_post_screen.dart';
import 'package:blog_app/screens/posts/update_post_screen.dart';

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
      initialRoute: '/',
      routes: {
        // '/': (context) => const HomeScreen(),
        // '/users': (context) => const UsersScreen(),
        '/posts': (context) => const PostsScreen(),
        // '/comments': (context) => const CommentsScreen(),
        '/createPost': (context) => const CreatePostScreen(),
      },
      onGenerateRoute: (settings) {
        // Manejar rutas con parámetros
        if (settings.name == '/updatePost') {
          final post = settings.arguments as Post;
          return MaterialPageRoute(
            builder: (context) => UpdatePostScreen(post: post),
          );
        }
        return null;
      },
      debugShowCheckedModeBanner: false,
    );
  }
}