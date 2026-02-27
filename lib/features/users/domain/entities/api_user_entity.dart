import 'package:equatable/equatable.dart';

/// User entity from JSONPlaceholder API
class ApiUserEntity extends Equatable {
  final int id;
  final String name;
  final String username;
  final String email;
  final String? phone;
  final String? website;
  final String? company;
  final String? address;

  const ApiUserEntity({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    this.phone,
    this.website,
    this.company,
    this.address,
  });

  /// Get initials from name
  String get initials {
    final names = name.trim().split(' ');
    if (names.isEmpty) return 'U';
    if (names.length == 1) return names[0][0].toUpperCase();
    return '${names[0][0]}${names[names.length - 1][0]}'.toUpperCase();
  }

  /// Get avatar color based on name
  int get avatarColorIndex => name.hashCode % 6;

  @override
  List<Object?> get props => [id, name, username, email, phone, website];
}
