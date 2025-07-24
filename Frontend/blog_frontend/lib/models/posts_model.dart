class Post {
  final int id;
  final String title;
  final String content;
  final int? userId; // Optional si no lo estás usando en la respuesta
  final String author;

  Post({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    this.userId,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      author: json['author'] ?? '',
      userId: json['user_id'],
    );
  }
}
