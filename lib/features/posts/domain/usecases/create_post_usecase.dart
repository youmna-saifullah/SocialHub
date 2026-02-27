import '../entities/post_entity.dart';
import '../repositories/post_repository.dart';

/// Use case for creating a post
class CreatePostUseCase {
  final PostRepository _repository;

  CreatePostUseCase(this._repository);

  Future<PostEntity> call({
    required String title,
    required String body,
    String? imageUrl,
  }) async {
    return await _repository.createPost(
      title: title,
      body: body,
      imageUrl: imageUrl,
    );
  }
}
