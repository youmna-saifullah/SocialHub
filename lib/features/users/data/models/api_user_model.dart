import '../../domain/entities/api_user_entity.dart';

// =============================================================================
// Task 6.3 Step 1: Create User model with fromJson(), toJson()
// =============================================================================

/// User model for data layer operations
class ApiUserModel extends ApiUserEntity {
  const ApiUserModel({
    required super.id,
    required super.name,
    required super.username,
    required super.email,
    super.phone,
    super.website,
    super.company,
    super.address,
  });

  // Task 6.3 Step 1: Create User model with fromJson()
  /// Create from JSON (JSONPlaceholder format)
  factory ApiUserModel.fromJson(Map<String, dynamic> json) {
    return ApiUserModel(
      id: json['id'] as int,
      name: json['name'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String?,
      website: json['website'] as String?,
      company: json['company'] != null
          ? (json['company'] as Map<String, dynamic>)['name'] as String?
          : null,
      address: json['address'] != null
          ? '${(json['address'] as Map<String, dynamic>)['city']}'
          : null,
    );
  }

  // Task 6.3 Step 1: Create User model with toJson()
  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'phone': phone,
      'website': website,
      'company': company,
      'address': address,
    };
  }
}
