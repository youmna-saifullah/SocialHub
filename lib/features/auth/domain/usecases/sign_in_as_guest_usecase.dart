import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

/// Use case for signing in as guest
class SignInAsGuestUseCase {
  final AuthRepository _repository;

  SignInAsGuestUseCase(this._repository);

  Future<UserEntity> call() async {
    return await _repository.signInAsGuest();
  }
}
