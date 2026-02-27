import 'package:equatable/equatable.dart';

/// User entity representing authenticated user
class UserEntity extends Equatable {
  final String id;
  final String? email;
  final String? displayName;
  final String? photoUrl;
  final bool isGuest;
  final DateTime? memberSince;

  const UserEntity({
    required this.id,
    this.email,
    this.displayName,
    this.photoUrl,
    this.isGuest = false,
    this.memberSince,
  });

  /// Create a guest user
  factory UserEntity.guest() {
    return UserEntity(
      id: 'guest_${DateTime.now().millisecondsSinceEpoch}',
      displayName: 'Guest User',
      isGuest: true,
      memberSince: DateTime.now(),
    );
  }

  /// Create from Firebase User
  factory UserEntity.fromFirebaseUser(dynamic firebaseUser) {
    return UserEntity(
      id: firebaseUser.uid ?? '',
      email: firebaseUser.email,
      displayName: firebaseUser.displayName ?? 'User',
      photoUrl: firebaseUser.photoURL,
      isGuest: false,
      memberSince: firebaseUser.metadata?.creationTime ?? DateTime.now(),
    );
  }

  /// Get initials from display name
  String get initials {
    if (displayName == null || displayName!.isEmpty) return 'U';
    final names = displayName!.trim().split(' ');
    if (names.length == 1) return names[0][0].toUpperCase();
    return '${names[0][0]}${names[names.length - 1][0]}'.toUpperCase();
  }

  /// Get formatted member since date
  String get formattedMemberSince {
    if (memberSince == null) return 'Unknown';
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                   'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return "${months[memberSince!.month - 1]} '${memberSince!.year.toString().substring(2)}";
  }

  @override
  List<Object?> get props => [id, email, displayName, photoUrl, isGuest];
}
