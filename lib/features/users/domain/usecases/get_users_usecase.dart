import '../entities/api_user_entity.dart';
import '../repositories/user_repository.dart';

/// Use case for getting all users
class GetUsersUseCase {
  final UserRepository _repository;

  GetUsersUseCase(this._repository);

  Future<List<ApiUserEntity>> call() async {
    return await _repository.getUsers();
  }
}
