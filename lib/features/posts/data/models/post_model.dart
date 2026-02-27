import '../../domain/entities/post_entity.dart';

// =============================================================================
// Task 6.1 Step 2: Create Post model class
// Task 6.1 Step 3: Add factory Post.fromJson(Map<String, dynamic> json)
// =============================================================================

/// Post model for data layer operations
class PostModel extends PostEntity {
  const PostModel({
    required super.id,
    required super.userId,
    required super.title,
    required super.body,
    super.imageUrl,
    super.createdAt,
  });

  // Task 6.1 Step 3: Add factory Post.fromJson(Map<String, dynamic> json)
  /// Create from JSON (JSONPlaceholder format)
  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] as int,
      userId: json['userId'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
      imageUrl: json['imageUrl'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
    );
  }

  // Task 6.2 Step 4: Add jsonEncode() for request body - toJson() provides the Map
  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'body': body,
      if (imageUrl != null) 'imageUrl': imageUrl,
      if (createdAt != null) 'createdAt': createdAt!.toIso8601String(),
    };
  }

  /// Create from entity
  factory PostModel.fromEntity(PostEntity entity) {
    return PostModel(
      id: entity.id,
      userId: entity.userId,
      title: entity.title,
      body: entity.body,
      imageUrl: entity.imageUrl,
      createdAt: entity.createdAt,
    );
  }
}
