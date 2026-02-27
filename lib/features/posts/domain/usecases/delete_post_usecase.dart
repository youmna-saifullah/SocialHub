import '../repositories/post_repository.dart';

/// Use case for deleting a post
class DeletePostUseCase {
  final PostRepository _repository;

  DeletePostUseCase(this._repository);

  Future<bool> call(int id) async {
    return await _repository.deletePost(id);
  }
}
