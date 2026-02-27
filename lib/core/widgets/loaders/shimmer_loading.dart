import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../theme/app_colors.dart';

// =============================================================================
// Task 6.1 Step 10: Handle ConnectionState.waiting with loading (shimmer effect)
// Task 6.3 Step 8: Show loading indicator when isLoading
// =============================================================================

/// Shimmer loading effect for skeleton screens
class ShimmerLoading extends StatelessWidget {
  final Widget child;
  final bool isLoading;

  const ShimmerLoading({
    super.key,
    required this.child,
    this.isLoading = true,
  });

  @override
  Widget build(BuildContext context) {
    if (!isLoading) return child;

    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBase,
      highlightColor: AppColors.shimmerHighlight,
      child: child,
    );
  }
}

/// Shimmer container for skeleton screens
class ShimmerContainer extends StatelessWidget {
  final double? width;
  final double height;
  final double borderRadius;

  const ShimmerContainer({
    super.key,
    this.width,
    required this.height,
    this.borderRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}

/// Post card skeleton for loading state
class PostCardSkeleton extends StatelessWidget {
  const PostCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ShimmerContainer(height: 180, borderRadius: 12),
            const SizedBox(height: 12),
            const ShimmerContainer(height: 20, width: 200),
            const SizedBox(height: 8),
            const ShimmerContainer(height: 14),
            const SizedBox(height: 4),
            const ShimmerContainer(height: 14, width: 250),
            const SizedBox(height: 12),
            Row(
              children: [
                ShimmerContainer(height: 32, width: 60, borderRadius: 16),
                const SizedBox(width: 8),
                ShimmerContainer(height: 32, width: 60, borderRadius: 16),
                const SizedBox(width: 8),
                ShimmerContainer(height: 32, width: 60, borderRadius: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// User tile skeleton for loading state
class UserTileSkeleton extends StatelessWidget {
  const UserTileSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      child: ListTile(
        leading: const CircleAvatar(
          radius: 24,
          backgroundColor: AppColors.white,
        ),
        title: const ShimmerContainer(height: 16, width: 120),
        subtitle: const ShimmerContainer(height: 12, width: 180),
      ),
    );
  }
}
