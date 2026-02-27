import 'package:flutter/foundation.dart';

import '../../../../core/enums/auth_status.dart';
import '../../../../core/enums/load_status.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/sign_in_as_guest_usecase.dart';
import '../../domain/usecases/sign_in_with_google_usecase.dart';
import '../../domain/usecases/sign_out_usecase.dart';
import '../../domain/repositories/auth_repository.dart';

/// Provider for authentication state management
class AuthProvider extends ChangeNotifier {
  final SignInWithGoogleUseCase _signInWithGoogleUseCase;
  final SignInAsGuestUseCase _signInAsGuestUseCase;
  final SignOutUseCase _signOutUseCase;
  final AuthRepository _authRepository;

  AuthProvider({
    required SignInWithGoogleUseCase signInWithGoogleUseCase,
    required SignInAsGuestUseCase signInAsGuestUseCase,
    required SignOutUseCase signOutUseCase,
    required AuthRepository authRepository,
  })  : _signInWithGoogleUseCase = signInWithGoogleUseCase,
        _signInAsGuestUseCase = signInAsGuestUseCase,
        _signOutUseCase = signOutUseCase,
        _authRepository = authRepository {
    _init();
  }

  // State
  AuthStatus _authStatus = AuthStatus.unknown;
  LoadStatus _loadStatus = LoadStatus.initial;
  UserEntity? _user;
  String? _error;

  // Getters
  AuthStatus get authStatus => _authStatus;
  LoadStatus get loadStatus => _loadStatus;
  UserEntity? get user => _user ?? _authRepository.currentUser;
  String? get error => _error;
  bool get isLoading => _loadStatus == LoadStatus.loading;
  bool get isLoggedIn => _authStatus == AuthStatus.authenticated || 
                         _authStatus == AuthStatus.guest;
  bool get isGuest => _authStatus == AuthStatus.guest;

  void _init() {
    _user = _authRepository.currentUser;
    if (_user != null) {
      _authStatus = _user!.isGuest ? AuthStatus.guest : AuthStatus.authenticated;
    } else {
      _authStatus = AuthStatus.unauthenticated;
    }

    // Listen to auth state changes
    _authRepository.authStateChanges.listen((user) {
      _user = user;
      if (user != null) {
        _authStatus = user.isGuest ? AuthStatus.guest : AuthStatus.authenticated;
      } else {
        _authStatus = AuthStatus.unauthenticated;
      }
      notifyListeners();
    });
  }

  /// Sign in with Google
  Future<bool> signInWithGoogle() async {
    _loadStatus = LoadStatus.loading;
    _error = null;
    notifyListeners();

    try {
      _user = await _signInWithGoogleUseCase();
      _authStatus = AuthStatus.authenticated;
      _loadStatus = LoadStatus.success;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _loadStatus = LoadStatus.error;
      notifyListeners();
      return false;
    }
  }

  /// Sign in as guest
  Future<bool> signInAsGuest() async {
    _loadStatus = LoadStatus.loading;
    _error = null;
    notifyListeners();

    try {
      _user = await _signInAsGuestUseCase();
      _authStatus = AuthStatus.guest;
      _loadStatus = LoadStatus.success;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _loadStatus = LoadStatus.error;
      notifyListeners();
      return false;
    }
  }

  /// Sign out
  Future<void> signOut() async {
    _loadStatus = LoadStatus.loading;
    notifyListeners();

    try {
      await _signOutUseCase();
      _user = null;
      _authStatus = AuthStatus.unauthenticated;
      _loadStatus = LoadStatus.success;
    } catch (e) {
      _error = e.toString();
      _loadStatus = LoadStatus.error;
    }
    notifyListeners();
  }

  /// Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }
}
