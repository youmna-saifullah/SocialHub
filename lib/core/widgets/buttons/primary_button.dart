import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

/// Primary gradient button matching the UI design
class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isExpanded;
  final double? width;
  final double height;
  final IconData? icon;
  final bool useGradient;

  const PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isExpanded = true,
    this.width,
    this.height = 56,
    this.icon,
    this.useGradient = true,
  });

  @override
  Widget build(BuildContext context) {
    final button = Container(
      width: isExpanded ? double.infinity : width,
      height: height,
      decoration: BoxDecoration(
        gradient: useGradient && onPressed != null
            ? AppColors.buttonGradient
            : null,
        color: !useGradient || onPressed == null
            ? onPressed == null
                ? AppColors.grey300
                : AppColors.primary
            : null,
        borderRadius: BorderRadius.circular(12),
        boxShadow: onPressed != null
            ? [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(12),
          child: Center(
            child: isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: AppColors.white,
                      strokeWidth: 2.5,
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (icon != null) ...[
                        Icon(icon, color: AppColors.white, size: 20),
                        const SizedBox(width: 8),
                      ],
                      Text(
                        text,
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );

    return button;
  }
}
