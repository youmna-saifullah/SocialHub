import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../domain/entities/user_entity.dart';

/// Data source for Firebase authentication
abstract class AuthRemoteDataSource {
  /// Get current user
  UserEntity? get currentUser;
  
  /// Check if user is logged in
  bool get isLoggedIn;
  
  /// Sign in with Google
  Future<UserEntity> signInWithGoogle();
  
  /// Sign out
  Future<void> signOut();
  
  /// Stream of auth state changes
  Stream<UserEntity?> get authStateChanges;
  
  /// Initialize the data source
  Future<void> initialize();
}

/// Implementation of AuthRemoteDataSource using Firebase
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _firebaseAuth;
  
  AuthRemoteDataSourceImpl({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;
  
  @override
  Future<void> initialize() async {
    // Initialize GoogleSignIn
    await GoogleSignIn.instance.initialize();
  }

  @override
  UserEntity? get currentUser {
    final firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser == null) return null;
    return UserEntity.fromFirebaseUser(firebaseUser);
  }

  @override
  bool get isLoggedIn => _firebaseAuth.currentUser != null;

  @override
  Future<UserEntity> signInWithGoogle() async {
    try {
      // Trigger the authentication flow using google_sign_in 7.x API
      final GoogleSignInAccount googleUser = await GoogleSignIn.instance.authenticate();

      // Get authentication tokens - only idToken is available in 7.x
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      // Create a new credential using idToken
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the credential
      final userCredential = await _firebaseAuth.signInWithCredential(credential);
      
      if (userCredential.user == null) {
        throw Exception('Failed to sign in with Google');
      }

      return UserEntity.fromFirebaseUser(userCredential.user!);
    } on GoogleSignInException catch (e) {
      throw Exception('Google sign in failed: ${e.description}');
    } catch (e) {
      throw Exception('Google sign in failed: $e');
    }
  }

  @override
  Future<void> signOut() async {
    await Future.wait([
      _firebaseAuth.signOut(),
      GoogleSignIn.instance.signOut(),
    ]);
  }

  @override
  Stream<UserEntity?> get authStateChanges {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      if (firebaseUser == null) return null;
      return UserEntity.fromFirebaseUser(firebaseUser);
    });
  }
}
