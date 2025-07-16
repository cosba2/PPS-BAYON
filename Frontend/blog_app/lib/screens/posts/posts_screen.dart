import 'package:flutter/material.dart';
import 'package:blog_app/services/api_service.dart';
import 'package:blog_app/models/post.dart';
import 'package:blog_app/screens/posts/create_post_screen.dart';
import 'package:blog_app/screens/posts/update_post_screen.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  _PostsScreenState createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  final ApiService _apiService = ApiService();
  List<Post> _posts = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  Future<void> _fetchPosts() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = '';
      });
      
      final response = await _apiService.getPosts();
      setState(() {
        _posts = response.map((post) => Post.fromJson(post)).toList();
        _isLoading = false;
      });
    } on ApiException catch (e) {
      setState(() {
        _errorMessage = e.message;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Error desconocido: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  Future<void> _createPost() async {
    final result = await Navigator.pushNamed(context, '/createPost');
    
    if (result == true) {
      await _fetchPosts();
    }
  }

  Future<void> _deletePost(int id) async {
    try {
      await _apiService.deletePost(id);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Post eliminado correctamente')),
      );
      await _fetchPosts();
    } on ApiException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.message}')),
      );
    }
  }

  Future<void> _updatePost(Post post) async {
    final result = await Navigator.pushNamed(
      context,
      '/updatePost',
      arguments: post,
    );
    
    if (result == true) {
      await _fetchPosts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _createPost,
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchPosts,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
              ? Center(child: Text(_errorMessage))
              : RefreshIndicator(
                  onRefresh: _fetchPosts,
                  child: ListView.builder(
                    itemCount: _posts.length,
                    itemBuilder: (context, index) {
                      final post = _posts[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                        child: ListTile(
                          title: Text(
                            post.title,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(post.body),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.blue),
                                onPressed: () => _updatePost(post),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _deletePost(post.id),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}