import 'package:blog_app/screens/comments/comments_screen.dart';
import 'package:blog_app/screens/comments/create_comment_screen.dart';
import 'package:blog_app/screens/comments/comment_detail_screen.dart';
import 'package:blog_app/screens/users/users_screen.dart';
import 'package:blog_app/screens/users/create_user_screen.dart';
import 'package:flutter/material.dart';
import 'package:blog_app/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Flask App',
      home: HomeScreen(),
      routes: {
        '/users': (context) => UsersScreen(),
        '/createUser': (context) => CreateUserScreen(),
        '/comments': (context) => CommentsScreen(),
        '/createComment': (context) => CreateCommentScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/commentDetail') {
          final args = settings.arguments as Map<String, dynamic>?;
          if (args != null && args.containsKey('commentId')) {
            return MaterialPageRoute(
              builder: (context) => CommentDetailScreen(commentId: args['commentId'] ?? ''),
            );
          }
        }
        return null;
      },
    );
  }
}
