import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

/// Gradient background container matching the UI design
class GradientBackground extends StatelessWidget {
  final Widget child;
  final List<Color>? colors;
  final AlignmentGeometry begin;
  final AlignmentGeometry end;

  const GradientBackground({
    super.key,
    required this.child,
    this.colors,
    this.begin = Alignment.topLeft,
    this.end = Alignment.bottomRight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: begin,
          end: end,
          colors: colors ?? [
            AppColors.gradientStart,
            AppColors.gradientMiddle,
            AppColors.gradientEnd,
          ],
        ),
      ),
      child: child,
    );
  }
}
