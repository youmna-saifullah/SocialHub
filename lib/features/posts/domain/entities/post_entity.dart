import 'package:equatable/equatable.dart';

/// Post entity representing a single post
class PostEntity extends Equatable {
  final int id;
  final int userId;
  final String title;
  final String body;
  final String? imageUrl;
  final DateTime? createdAt;

  const PostEntity({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
    this.imageUrl,
    this.createdAt,
  });

  PostEntity copyWith({
    int? id,
    int? userId,
    String? title,
    String? body,
    String? imageUrl,
    DateTime? createdAt,
  }) {
    return PostEntity(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      body: body ?? this.body,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [id, userId, title, body, imageUrl, createdAt];
}
