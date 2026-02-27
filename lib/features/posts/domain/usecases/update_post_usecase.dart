import '../entities/post_entity.dart';
import '../repositories/post_repository.dart';

/// Use case for updating a post
class UpdatePostUseCase {
  final PostRepository _repository;

  UpdatePostUseCase(this._repository);

  Future<PostEntity> call({
    required int id,
    required String title,
    required String body,
    String? imageUrl,
  }) async {
    return await _repository.updatePost(
      id: id,
      title: title,
      body: body,
      imageUrl: imageUrl,
    );
  }
}
