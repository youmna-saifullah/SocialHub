import '../../domain/entities/post_entity.dart';
import '../../domain/repositories/post_repository.dart';
import '../datasources/post_remote_data_source.dart';

/// Implementation of PostRepository
class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource _remoteDataSource;

  PostRepositoryImpl({required PostRemoteDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  @override
  Future<List<PostEntity>> getPosts() async {
    return await _remoteDataSource.getPosts();
  }

  @override
  Future<PostEntity> getPostById(int id) async {
    return await _remoteDataSource.getPostById(id);
  }

  @override
  Future<PostEntity> createPost({
    required String title,
    required String body,
    String? imageUrl,
  }) async {
    final post = await _remoteDataSource.createPost(
      title: title,
      body: body,
    );
    
    // Add imageUrl if provided (JSONPlaceholder doesn't support it, but we handle locally)
    return post.copyWith(imageUrl: imageUrl);
  }

  @override
  Future<PostEntity> updatePost({
    required int id,
    required String title,
    required String body,
    String? imageUrl,
  }) async {
    final post = await _remoteDataSource.updatePost(
      id: id,
      title: title,
      body: body,
    );
    
    return post.copyWith(imageUrl: imageUrl);
  }

  @override
  Future<bool> deletePost(int id) async {
    return await _remoteDataSource.deletePost(id);
  }
}
