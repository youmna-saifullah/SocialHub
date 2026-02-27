import '../entities/api_user_entity.dart';

/// Repository interface for user operations
abstract class UserRepository {
  /// Get all users
  Future<List<ApiUserEntity>> getUsers();
  
  /// Get user by ID
  Future<ApiUserEntity> getUserById(int id);
  
  /// Search users by name or email
  Future<List<ApiUserEntity>> searchUsers(String query);
}
