import 'package:flutter/foundation.dart';

import '../../../../core/enums/load_status.dart';
import '../../domain/entities/post_entity.dart';
import '../../domain/usecases/create_post_usecase.dart';
import '../../domain/usecases/delete_post_usecase.dart';
import '../../domain/usecases/get_posts_usecase.dart';
import '../../domain/usecases/update_post_usecase.dart';

// =============================================================================
// Task 6.3 Step 2: Create PostsProvider extends ChangeNotifier
// Task 6.3 Step 3: Add List<Post> posts, bool isLoading, String? error
// =============================================================================

/// Provider for posts state management
class PostsProvider extends ChangeNotifier {
  final GetPostsUseCase _getPostsUseCase;
  final CreatePostUseCase _createPostUseCase;
  final UpdatePostUseCase _updatePostUseCase;
  final DeletePostUseCase _deletePostUseCase;

  PostsProvider({
    required GetPostsUseCase getPostsUseCase,
    required CreatePostUseCase createPostUseCase,
    required UpdatePostUseCase updatePostUseCase,
    required DeletePostUseCase deletePostUseCase,
  })  : _getPostsUseCase = getPostsUseCase,
        _createPostUseCase = createPostUseCase,
        _updatePostUseCase = updatePostUseCase,
        _deletePostUseCase = deletePostUseCase;

  // Task 6.3 Step 3: Add List<Post> posts, bool isLoading, String? error
  // State
  List<PostEntity> _posts = [];
  LoadStatus _loadStatus = LoadStatus.initial;
  String? _error;
  bool _isRefreshing = false;

  // Getters
  List<PostEntity> get posts => _posts;
  LoadStatus get loadStatus => _loadStatus;
  String? get error => _error;
  bool get isLoading => _loadStatus == LoadStatus.loading;
  bool get isRefreshing => _isRefreshing;

  // Task 6.3 Step 5: Implement fetchPosts() setting states
  // Task 6.3 Step 6: Use notifyListeners() after state changes
  /// Fetch all posts
  Future<void> fetchPosts() async {
    if (_loadStatus == LoadStatus.loading) return;

    _loadStatus = LoadStatus.loading;
    _error = null;
    // Task 6.3 Step 6: Use notifyListeners() after state changes
    notifyListeners();

    try {
      _posts = await _getPostsUseCase();
      _loadStatus = LoadStatus.success;
    } catch (e) {
      _error = e.toString();
      _loadStatus = LoadStatus.error;
    }
    notifyListeners();
  }

  // Task 6.3 Step 10: Implement RefreshIndicator with onRefresh
  /// Refresh posts (pull-to-refresh)
  Future<void> refreshPosts() async {
    _isRefreshing = true;
    notifyListeners();

    try {
      _posts = await _getPostsUseCase();
      _loadStatus = LoadStatus.success;
      _error = null;
    } catch (e) {
      _error = e.toString();
    }
    
    _isRefreshing = false;
    notifyListeners();
  }

  // Task 6.2 Step 9: Call createPost() on submit
  /// Create a new post
  Future<bool> createPost({
    required String title,
    required String body,
    String? imageUrl,
  }) async {
    try {
      final newPost = await _createPostUseCase(
        title: title,
        body: body,
        imageUrl: imageUrl,
      );
      
      // Add to the beginning of the list (most recent first)
      _posts = [newPost, ..._posts];
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  // Task 6.2 Step 5: Implement updatePost() - called from Provider
  /// Update an existing post
  Future<bool> updatePost({
    required int id,
    required String title,
    required String body,
    String? imageUrl,
  }) async {
    try {
      final updatedPost = await _updatePostUseCase(
        id: id,
        title: title,
        body: body,
        imageUrl: imageUrl,
      );
      
      // Update the post in the list
      final index = _posts.indexWhere((p) => p.id == id);
      if (index != -1) {
        _posts[index] = updatedPost;
        _posts = List.from(_posts); // Trigger rebuild
        notifyListeners();
      }
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  // Task 6.2 Step 6: Create deletePost() - called from Provider
  /// Delete a post
  Future<bool> deletePost(int id) async {
    try {
      final success = await _deletePostUseCase(id);
      
      if (success) {
        _posts.removeWhere((p) => p.id == id);
        _posts = List.from(_posts); // Trigger rebuild
        notifyListeners();
      }
      return success;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  /// Get a specific post by ID
  PostEntity? getPostById(int id) {
    try {
      return _posts.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }
}
