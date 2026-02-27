/// Authentication status enum
enum AuthStatus {
  unknown,
  authenticated,
  unauthenticated,
  guest,
}

/// Extension methods for AuthStatus
extension AuthStatusExtension on AuthStatus {
  bool get isUnknown => this == AuthStatus.unknown;
  bool get isAuthenticated => this == AuthStatus.authenticated;
  bool get isUnauthenticated => this == AuthStatus.unauthenticated;
  bool get isGuest => this == AuthStatus.guest;
  
  bool get isLoggedIn => isAuthenticated || isGuest;
}
