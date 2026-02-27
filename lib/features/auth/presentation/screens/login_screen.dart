import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/buttons/primary_button.dart';
import '../../../../core/widgets/buttons/social_button.dart';
import '../../../../core/widgets/more/gradient_background.dart';
import '../providers/auth_provider.dart';

/// Login screen with Google and Guest options
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        colors: const [
          Color(0xFFB8E0F0),
          Color(0xFFD4C8F0),
        ],
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const Spacer(),
                
                // Logo and welcome text
                _buildHeader(context),
                
                const Spacer(),
                
                // Login options
                _buildLoginOptions(context),
                
                const SizedBox(height: 24),
                
                // Privacy notice
                _buildPrivacyNotice(context),
                
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        // Logo
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20),
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
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ),
        )
            .animate()
            .fadeIn(duration: 500.ms)
            .scale(begin: const Offset(0.8, 0.8), duration: 500.ms),

        const SizedBox(height: 32),

        // Welcome text
        Text(
          AppStrings.welcomeTo,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.textSecondaryLight,
              ),
        ).animate().fadeIn(delay: 200.ms, duration: 400.ms),

        const SizedBox(height: 8),

        Text(
          AppStrings.connectSphere,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
        ).animate().fadeIn(delay: 300.ms, duration: 400.ms),
      ],
    );
  }

  Widget _buildLoginOptions(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        return Column(
          children: [
            // Google Sign In
            SocialButton.google(
              onPressed: authProvider.isLoading
                  ? null
                  : () => _handleGoogleSignIn(context, authProvider),
              isLoading: authProvider.isLoading,
            ).animate().fadeIn(delay: 400.ms, duration: 400.ms),

            const SizedBox(height: 16),

            // OR divider
            Row(
              children: [
                const Expanded(child: Divider(color: AppColors.grey300)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    AppStrings.or,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondaryLight,
                        ),
                  ),
                ),
                const Expanded(child: Divider(color: AppColors.grey300)),
              ],
            ).animate().fadeIn(delay: 500.ms, duration: 400.ms),

            const SizedBox(height: 16),

            // Guest Login
            PrimaryButton(
              text: AppStrings.loginAsGuest,
              onPressed: authProvider.isLoading
                  ? null
                  : () => _handleGuestSignIn(context, authProvider),
              useGradient: false,
            ).animate().fadeIn(delay: 600.ms, duration: 400.ms),
          ],
        );
      },
    );
  }

  Widget _buildPrivacyNotice(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: 'By continuing, you agree to our ',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondaryLight,
            ),
        children: [
          TextSpan(
            text: AppStrings.termsOfService,
            style: TextStyle(
              color: AppColors.primary,
              decoration: TextDecoration.underline,
            ),
          ),
          const TextSpan(text: ' and '),
          TextSpan(
            text: AppStrings.privacyPolicy,
            style: TextStyle(
              color: AppColors.primary,
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    ).animate().fadeIn(delay: 700.ms, duration: 400.ms);
  }

  Future<void> _handleGoogleSignIn(
    BuildContext context,
    AuthProvider authProvider,
  ) async {
    final success = await authProvider.signInWithGoogle();
    if (success && context.mounted) {
      context.goNamed(RouteNames.posts);
    } else if (authProvider.error != null && context.mounted) {
      context.showErrorSnackBar(authProvider.error!);
    }
  }

  Future<void> _handleGuestSignIn(
    BuildContext context,
    AuthProvider authProvider,
  ) async {
    final success = await authProvider.signInAsGuest();
    if (success && context.mounted) {
      context.goNamed(RouteNames.posts);
    } else if (authProvider.error != null && context.mounted) {
      context.showErrorSnackBar(authProvider.error!);
    }
  }
}
