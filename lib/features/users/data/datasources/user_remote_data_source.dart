import '../../../../core/services/dio/dio_client.dart';
import '../models/api_user_model.dart';

// =============================================================================
// Task 6.3 Step 4: Create ApiService for API calls (UserRemoteDataSource)
// =============================================================================

/// Remote data source for users using JSONPlaceholder API
abstract class UserRemoteDataSource {
  /// Get all users
  Future<List<ApiUserModel>> getUsers();
  
  /// Get user by ID
  Future<ApiUserModel> getUserById(int id);
}

/// Implementation using Dio client
class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final DioClient _dioClient;

  UserRemoteDataSourceImpl({required DioClient dioClient})
      : _dioClient = dioClient;

  // Task 6.3 Step 5: Implement fetchUsers() setting states
  @override
  Future<List<ApiUserModel>> getUsers() async {
    try {
      final response = await _dioClient.get('/users');
      
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;
        return data
            .map((json) => ApiUserModel.fromJson(json as Map<String, dynamic>))
            .toList();
      }
      
      throw Exception('Failed to load users');
    } catch (e) {
      throw Exception('Failed to load users: $e');
    }
  }

  @override
  Future<ApiUserModel> getUserById(int id) async {
    try {
      final response = await _dioClient.get('/users/$id');
      
      if (response.statusCode == 200) {
        return ApiUserModel.fromJson(response.data as Map<String, dynamic>);
      }
      
      throw Exception('Failed to load user');
    } catch (e) {
      throw Exception('Failed to load user: $e');
    }
  }
}
