import '../../domain/entities/api_user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_remote_data_source.dart';

/// Implementation of UserRepository
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource _remoteDataSource;

  UserRepositoryImpl({required UserRemoteDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  @override
  Future<List<ApiUserEntity>> getUsers() async {
    return await _remoteDataSource.getUsers();
  }

  @override
  Future<ApiUserEntity> getUserById(int id) async {
    return await _remoteDataSource.getUserById(id);
  }

  @override
  Future<List<ApiUserEntity>> searchUsers(String query) async {
    // Get all users and filter locally
    final users = await _remoteDataSource.getUsers();
    final lowercaseQuery = query.toLowerCase();
    
    return users.where((user) {
      return user.name.toLowerCase().contains(lowercaseQuery) ||
             user.email.toLowerCase().contains(lowercaseQuery) ||
             user.username.toLowerCase().contains(lowercaseQuery);
    }).toList();
  }
}
