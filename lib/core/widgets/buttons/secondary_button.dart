import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

/// Secondary outlined button
class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isExpanded;
  final double? width;
  final double height;
  final IconData? icon;
  final Color? borderColor;
  final Color? textColor;

  const SecondaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isExpanded = true,
    this.width,
    this.height = 56,
    this.icon,
    this.borderColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveBorderColor = borderColor ?? AppColors.primary;
    final effectiveTextColor = textColor ?? AppColors.primary;

    return Container(
      width: isExpanded ? double.infinity : width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: onPressed != null ? effectiveBorderColor : AppColors.grey300,
          width: 1.5,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(12),
          child: Center(
            child: isLoading
                ? SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: effectiveTextColor,
                      strokeWidth: 2.5,
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (icon != null) ...[
                        Icon(
                          icon,
                          color: onPressed != null
                              ? effectiveTextColor
                              : AppColors.grey400,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                      ],
                      Text(
                        text,
                        style: TextStyle(
                          color: onPressed != null
                              ? effectiveTextColor
                              : AppColors.grey400,
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
  }
}
