import 'dart:convert';

import '../../domain/entities/user_entity.dart';

/// User model for data layer operations
class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    super.email,
    super.displayName,
    super.photoUrl,
    super.isGuest,
    super.memberSince,
  });

  /// Create from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String?,
      displayName: json['displayName'] as String?,
      photoUrl: json['photoUrl'] as String?,
      isGuest: json['isGuest'] as bool? ?? false,
      memberSince: json['memberSince'] != null
          ? DateTime.parse(json['memberSince'] as String)
          : null,
    );
  }

  /// Create from entity
  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      email: entity.email,
      displayName: entity.displayName,
      photoUrl: entity.photoUrl,
      isGuest: entity.isGuest,
      memberSince: entity.memberSince,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'isGuest': isGuest,
      'memberSince': memberSince?.toIso8601String(),
    };
  }

  /// Convert to JSON string
  String toJsonString() => jsonEncode(toJson());

  /// Create from JSON string
  factory UserModel.fromJsonString(String jsonString) {
    return UserModel.fromJson(jsonDecode(jsonString) as Map<String, dynamic>);
  }
}
