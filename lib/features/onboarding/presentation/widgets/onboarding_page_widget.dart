import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/onboarding_page_data.dart';

/// Single page widget for onboarding
class OnboardingPageWidget extends StatelessWidget {
  final OnboardingPageData data;

  const OnboardingPageWidget({
    super.key,
    required this.data,
  });

  IconData _getIconFromName(String name) {
    switch (name) {
      case 'message':
        return Icons.message_rounded;
      case 'image':
        return Icons.image_rounded;
      case 'person':
        return Icons.person_rounded;
      default:
        return Icons.star_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Illustration container
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Center(
              child: Icon(
                _getIconFromName(data.illustrationIcon),
                size: 80,
                color: AppColors.primary,
              ),
            ),
          )
              .animate()
              .fadeIn(duration: 500.ms)
              .scale(
                begin: const Offset(0.8, 0.8),
                end: const Offset(1, 1),
                duration: 500.ms,
                curve: Curves.easeOutBack,
              ),

          const SizedBox(height: 48),

          // Title
          Text(
            data.title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimaryLight,
                ),
            textAlign: TextAlign.center,
          )
              .animate()
              .fadeIn(delay: 200.ms, duration: 400.ms)
              .slideY(begin: 0.2, end: 0),

          const SizedBox(height: 16),

          // Description
          Text(
            data.description,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textSecondaryLight,
                ),
            textAlign: TextAlign.center,
          )
              .animate()
              .fadeIn(delay: 400.ms, duration: 400.ms)
              .slideY(begin: 0.2, end: 0),
        ],
      ),
    );
  }
}
