import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/services/local_storage/local_storage_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/more/gradient_background.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

/// Splash screen with animated logo
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateAfterDelay();
  }

  Future<void> _navigateAfterDelay() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;

    final localStorage = context.read<LocalStorageService>();
    final authProvider = context.read<AuthProvider>();

    final onboardingCompleted = localStorage.getOnboardingCompleted();
    final isLoggedIn = authProvider.isLoggedIn;

    if (!onboardingCompleted) {
      context.goNamed(RouteNames.onboarding);
    } else if (!isLoggedIn) {
      context.goNamed(RouteNames.login);
    } else {
      context.goNamed(RouteNames.posts);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        colors: const [
          Color(0xFF87CEEB),
          Color(0xFFB8D4E8),
          Color(0xFFD4C8F0),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withValues(alpha: 0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'CS',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                )
                    .animate()
                    .fadeIn(duration: 600.ms)
                    .scale(
                      begin: const Offset(0.8, 0.8),
                      end: const Offset(1, 1),
                      duration: 600.ms,
                      curve: Curves.easeOutBack,
                    ),
                
                const SizedBox(height: 24),
                
                // App Name
                Text(
                  AppStrings.connectSphere,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                )
                    .animate()
                    .fadeIn(delay: 300.ms, duration: 600.ms)
                    .slideY(begin: 0.3, end: 0, duration: 600.ms),
                
                const SizedBox(height: 8),
                
                // Tagline
                Text(
                  AppStrings.tagline,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textSecondaryLight,
                  ),
                )
                    .animate()
                    .fadeIn(delay: 500.ms, duration: 600.ms)
                    .slideY(begin: 0.3, end: 0, duration: 600.ms),
                
                const SizedBox(height: 48),
                
                // Loading indicator
                const CircularProgressIndicator(
                  color: AppColors.primary,
                  strokeWidth: 3,
                )
                    .animate()
                    .fadeIn(delay: 700.ms, duration: 400.ms),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
