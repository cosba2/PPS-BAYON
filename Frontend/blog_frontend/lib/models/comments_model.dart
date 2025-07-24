class Comment {
  final int id;
  final String content;
  final int userId;
  final int postId;
  final String author;

  Comment({
    required this.id,
    required this.content,
    required this.userId,
    required this.postId,
    this.author = "",
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id_comment'] ?? json['id'] ?? 0,
      content: json['content'] ?? "",
      userId: json['user_id'] ?? 0,
      postId: json['post_id'] ?? 0,
      author: json['author'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'user_id': userId,
      'post_id': postId,
    };
  }
}
