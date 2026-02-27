import '../../../../core/services/local_storage/local_storage_service.dart';
import '../../domain/entities/user_entity.dart';
import '../models/user_model.dart';

/// Data source for local auth data storage
abstract class AuthLocalDataSource {
  /// Get cached user
  UserEntity? getCachedUser();
  
  /// Cache user
  Future<void> cacheUser(UserEntity user);
  
  /// Clear cached user
  Future<void> clearCachedUser();
  
  /// Check if there's a cached user
  bool get hasCachedUser;
}

/// Implementation using LocalStorageService
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final LocalStorageService _localStorage;

  AuthLocalDataSourceImpl({required LocalStorageService localStorage})
      : _localStorage = localStorage;

  @override
  UserEntity? getCachedUser() {
    final userJson = _localStorage.getUserData();
    if (userJson == null) return null;
    try {
      return UserModel.fromJsonString(userJson);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> cacheUser(UserEntity user) async {
    final userModel = UserModel.fromEntity(user);
    await _localStorage.setUserData(userModel.toJsonString());
  }

  @override
  Future<void> clearCachedUser() async {
    await _localStorage.clearUserData();
  }

  @override
  bool get hasCachedUser => _localStorage.getUserData() != null;
}
