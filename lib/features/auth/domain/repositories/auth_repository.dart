import '../entities/user_entity.dart';

/// Repository interface for authentication operations
abstract class AuthRepository {
  /// Get current authenticated user
  UserEntity? get currentUser;
  
  /// Check if user is logged in
  bool get isLoggedIn;
  
  /// Sign in with Google
  Future<UserEntity> signInWithGoogle();
  
  /// Sign in as guest
  Future<UserEntity> signInAsGuest();
  
  /// Sign out
  Future<void> signOut();
  
  /// Stream of auth state changes
  Stream<UserEntity?> get authStateChanges;
}
