import '../../../../core/services/dio/dio_client.dart';
import '../models/post_model.dart';

// =============================================================================
// Task 6.1 Step 4: Create ApiService class (PostRemoteDataSource)
// Task 6.1 Step 5: Implement Future<List<Post>> fetchPosts()
// Task 6.2 Step 1: Create ApiService class for CRUD operations
// =============================================================================

/// Remote data source for posts using JSONPlaceholder API
abstract class PostRemoteDataSource {
  /// Get all posts
  Future<List<PostModel>> getPosts();
  
  /// Get post by ID
  Future<PostModel> getPostById(int id);
  
  /// Create a new post
  Future<PostModel> createPost({
    required String title,
    required String body,
    int userId,
  });
  
  /// Update a post
  Future<PostModel> updatePost({
    required int id,
    required String title,
    required String body,
    int userId,
  });
  
  /// Delete a post
  Future<bool> deletePost(int id);
}

/// Implementation using Dio client
class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final DioClient _dioClient;

  PostRemoteDataSourceImpl({required DioClient dioClient})
      : _dioClient = dioClient;

  // Task 6.1 Step 5: Implement Future<List<Post>> fetchPosts()
  // Task 6.1 Step 6: Use http.get(Uri.parse(url)) - using Dio equivalent: _dioClient.get()
  // Task 6.1 Step 7: Parse response: jsonDecode(response.body) - Dio auto-parses JSON
  // Task 6.1 Step 8: Map JSON to List<Post>
  @override
  Future<List<PostModel>> getPosts() async {
    try {
      final response = await _dioClient.get('/posts');
      
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;
        return data
            .map((json) => PostModel.fromJson(json as Map<String, dynamic>))
            .toList();
      }
      
      throw Exception('Failed to load posts');
    } catch (e) {
      throw Exception('Failed to load posts: $e');
    }
  }

  @override
  Future<PostModel> getPostById(int id) async {
    try {
      final response = await _dioClient.get('/posts/$id');
      
      if (response.statusCode == 200) {
        return PostModel.fromJson(response.data as Map<String, dynamic>);
      }
      
      throw Exception('Failed to load post');
    } catch (e) {
      throw Exception('Failed to load post: $e');
    }
  }

  // Task 6.2 Step 2: Implement Future<Post> createPost(Post post)
  // Task 6.2 Step 3: Use http.post() with headers and body - using Dio equivalent
  // Task 6.2 Step 4: Add jsonEncode() for request body - Dio handles serialization
  @override
  Future<PostModel> createPost({
    required String title,
    required String body,
    int userId = 1,
  }) async {
    try {
      final response = await _dioClient.post(
        '/posts',
        data: {
          'title': title,
          'body': body,
          'userId': userId,
        },
      );
      
      if (response.statusCode == 201 || response.statusCode == 200) {
        return PostModel.fromJson(response.data as Map<String, dynamic>);
      }
      
      throw Exception('Failed to create post');
    } catch (e) {
      throw Exception('Failed to create post: $e');
    }
  }

  // Task 6.2 Step 5: Implement updatePost() with http.put() - using Dio equivalent
  @override
  Future<PostModel> updatePost({
    required int id,
    required String title,
    required String body,
    int userId = 1,
  }) async {
    try {
      final response = await _dioClient.put(
        '/posts/$id',
        data: {
          'id': id,
          'title': title,
          'body': body,
          'userId': userId,
        },
      );
      
      if (response.statusCode == 200) {
        return PostModel.fromJson(response.data as Map<String, dynamic>);
      }
      
      throw Exception('Failed to update post');
    } catch (e) {
      throw Exception('Failed to update post: $e');
    }
  }

  // Task 6.2 Step 6: Create deletePost() with http.delete() - using Dio equivalent
  @override
  Future<bool> deletePost(int id) async {
    try {
      final response = await _dioClient.delete('/posts/$id');
      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Failed to delete post: $e');
    }
  }
}
