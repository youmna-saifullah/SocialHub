import '../entities/post_entity.dart';
import '../repositories/post_repository.dart';

/// Use case for getting all posts
class GetPostsUseCase {
  final PostRepository _repository;

  GetPostsUseCase(this._repository);

  Future<List<PostEntity>> call() async {
    return await _repository.getPosts();
  }
}
