import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../constants/app_strings.dart';
import '../buttons/primary_button.dart';

// =============================================================================
// Task 6.1 Step 10: Handle ConnectionState.waiting with loading
// Task 6.1 Step 11: Handle errors with snapshot.hasError
// Task 6.3 Step 8: Show loading indicator when isLoading
// Task 6.3 Step 9: Display error with error widget
// =============================================================================

/// Error state widget with retry action
// Task 6.1 Step 11: Handle errors with error widget
// Task 6.3 Step 9: Display error with error widget
class ErrorStateWidget extends StatelessWidget {
  final String? message;
  final VoidCallback? onRetry;
  final IconData icon;

  const ErrorStateWidget({
    super.key,
    this.message,
    this.onRetry,
    this.icon = Icons.error_outline,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 80,
              color: AppColors.error,
            ),
            const SizedBox(height: 24),
            Text(
              message ?? AppStrings.somethingWentWrong,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              PrimaryButton(
                text: AppStrings.tryAgain,
                onPressed: onRetry,
                isExpanded: false,
                width: 150,
                height: 48,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Empty state widget
class EmptyStateWidget extends StatelessWidget {
  final String message;
  final IconData icon;
  final Widget? action;

  const EmptyStateWidget({
    super.key,
    required this.message,
    this.icon = Icons.inbox_outlined,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 80,
              color: AppColors.grey400,
            ),
            const SizedBox(height: 24),
            Text(
              message,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.grey500,
                  ),
              textAlign: TextAlign.center,
            ),
            if (action != null) ...[
              const SizedBox(height: 24),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}
