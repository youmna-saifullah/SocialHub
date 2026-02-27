import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/posts/presentation/screens/create_edit_post_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../../features/users/presentation/screens/users_screen.dart';
import '../services/local_storage/local_storage_service.dart';
import 'route_names.dart';
import 'route_transitions.dart';

/// GoRouter configuration for the app
class AppRouter {
  final LocalStorageService _localStorage;
  
  AppRouter({required LocalStorageService localStorage})
      : _localStorage = localStorage;

  late final GoRouter router = GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    redirect: _redirect,
    routes: [
      // Splash
      GoRoute(
        path: '/',
        name: RouteNames.splash,
        pageBuilder: (context, state) => RouteTransitions.fade(
          key: state.pageKey,
          child: const SplashScreen(),
        ),
      ),
      
      // Onboarding
      GoRoute(
        path: '/onboarding',
        name: RouteNames.onboarding,
        pageBuilder: (context, state) => RouteTransitions.fade(
          key: state.pageKey,
          child: const OnboardingScreen(),
        ),
      ),
      
      // Login
      GoRoute(
        path: '/login',
        name: RouteNames.login,
        pageBuilder: (context, state) => RouteTransitions.fade(
          key: state.pageKey,
          child: const LoginScreen(),
        ),
      ),
      
      // Home (with bottom navigation)
      ShellRoute(
        builder: (context, state, child) => HomeScreen(child: child),
        routes: [
          // Posts tab
          GoRoute(
            path: '/posts',
            name: RouteNames.posts,
            pageBuilder: (context, state) => RouteTransitions.fade(
              key: state.pageKey,
              child: const _PostsPlaceholder(),
            ),
            routes: [
              GoRoute(
                path: 'create',
                name: RouteNames.createPost,
                pageBuilder: (context, state) => RouteTransitions.slideUp(
                  key: state.pageKey,
                  child: const CreateEditPostScreen(),
                ),
              ),
              GoRoute(
                path: 'edit/:postId',
                name: RouteNames.editPost,
                pageBuilder: (context, state) {
                  final postId = int.parse(state.pathParameters['postId']!);
                  return RouteTransitions.slideRight(
                    key: state.pageKey,
                    child: CreateEditPostScreen(postId: postId),
                  );
                },
              ),
            ],
          ),
          
          // Users tab
          GoRoute(
            path: '/users',
            name: RouteNames.users,
            pageBuilder: (context, state) => RouteTransitions.fade(
              key: state.pageKey,
              child: const UsersScreen(),
            ),
          ),
          
          // Profile tab
          GoRoute(
            path: '/profile',
            name: RouteNames.profile,
            pageBuilder: (context, state) => RouteTransitions.fade(
              key: state.pageKey,
              child: const ProfileScreen(),
            ),
          ),
          
          // Settings tab
          GoRoute(
            path: '/settings',
            name: RouteNames.settings,
            pageBuilder: (context, state) => RouteTransitions.fade(
              key: state.pageKey,
              child: const SettingsScreen(),
            ),
          ),
        ],
      ),
    ],
    errorPageBuilder: (context, state) => RouteTransitions.fade(
      key: state.pageKey,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                'Page not found',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                state.uri.toString(),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => context.go('/posts'),
                child: const Text('Go Home'),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  String? _redirect(BuildContext context, GoRouterState state) {
    final authProvider = context.read<AuthProvider>();
    final isLoggedIn = authProvider.isLoggedIn;
    final onboardingCompleted = _localStorage.getOnboardingCompleted();
    
    final isSplash = state.matchedLocation == '/';
    final isOnboarding = state.matchedLocation == '/onboarding';
    final isLogin = state.matchedLocation == '/login';
    
    // If on splash, let it handle navigation
    if (isSplash) return null;
    
    // If not completed onboarding, go to onboarding
    if (!onboardingCompleted && !isOnboarding) {
      return '/onboarding';
    }
    
    // If completed onboarding but not logged in, go to login
    if (onboardingCompleted && !isLoggedIn && !isLogin) {
      return '/login';
    }
    
    // If logged in and trying to access login/onboarding, go to posts
    if (isLoggedIn && (isLogin || isOnboarding)) {
      return '/posts';
    }
    
    return null;
  }
}

// Placeholder for posts - will be replaced with actual widget from shell
class _PostsPlaceholder extends StatelessWidget {
  const _PostsPlaceholder();

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
