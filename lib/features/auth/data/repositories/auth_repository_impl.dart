import 'dart:async';

import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';

/// Implementation of AuthRepository
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;
  
  UserEntity? _currentUser;
  final StreamController<UserEntity?> _authStateController = 
      StreamController<UserEntity?>.broadcast();

  AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
    required AuthLocalDataSource localDataSource,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource {
    _init();
  }

  void _init() {
    // Check for cached user (guest)
    _currentUser = _localDataSource.getCachedUser();
    if (_currentUser != null) {
      _authStateController.add(_currentUser);
    }

    // Listen to Firebase auth state changes
    _remoteDataSource.authStateChanges.listen((user) {
      if (user != null) {
        _currentUser = user;
        _localDataSource.cacheUser(user);
      } else if (_currentUser?.isGuest != true) {
        _currentUser = null;
      }
      _authStateController.add(_currentUser);
    });
  }

  @override
  UserEntity? get currentUser => _currentUser ?? _remoteDataSource.currentUser;

  @override
  bool get isLoggedIn => _currentUser != null || _remoteDataSource.isLoggedIn;

  @override
  Future<UserEntity> signInWithGoogle() async {
    final user = await _remoteDataSource.signInWithGoogle();
    _currentUser = user;
    await _localDataSource.cacheUser(user);
    _authStateController.add(user);
    return user;
  }

  @override
  Future<UserEntity> signInAsGuest() async {
    final guestUser = UserEntity.guest();
    _currentUser = guestUser;
    await _localDataSource.cacheUser(guestUser);
    _authStateController.add(guestUser);
    return guestUser;
  }

  @override
  Future<void> signOut() async {
    if (_currentUser?.isGuest != true) {
      await _remoteDataSource.signOut();
    }
    _currentUser = null;
    await _localDataSource.clearCachedUser();
    _authStateController.add(null);
  }

  @override
  Stream<UserEntity?> get authStateChanges => _authStateController.stream;
}
