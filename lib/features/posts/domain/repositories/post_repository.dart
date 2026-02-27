import '../entities/post_entity.dart';

/// Repository interface for post operations
abstract class PostRepository {
  /// Get all posts
  Future<List<PostEntity>> getPosts();
  
  /// Get post by ID
  Future<PostEntity> getPostById(int id);
  
  /// Create a new post
  Future<PostEntity> createPost({
    required String title,
    required String body,
    String? imageUrl,
  });
  
  /// Update an existing post
  Future<PostEntity> updatePost({
    required int id,
    required String title,
    required String body,
    String? imageUrl,
  });
  
  /// Delete a post
  Future<bool> deletePost(int id);
}
