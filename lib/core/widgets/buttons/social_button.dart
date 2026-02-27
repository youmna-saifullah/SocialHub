import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

/// Social login button (Google, etc.)
class SocialButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Widget? icon;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? textColor;


  const SocialButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.isLoading = false,
    this.backgroundColor,
    this.textColor,
  });

  /// Google Sign In button
  factory SocialButton.google({
    required VoidCallback? onPressed,
    bool isLoading = false,
  }) {
    return SocialButton(
      text: 'Continue with Google',
      onPressed: onPressed,
      isLoading: isLoading,
      backgroundColor: AppColors.white,
      textColor: AppColors.textPrimaryLight,
      icon: Image.network(
        'https://www.google.com/favicon.ico',
        width: 24,
        height: 24,
        errorBuilder: (context, error, stackTrace) => const Icon(
          Icons.g_mobiledata,
          size: 24,
          color: Colors.red,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grey200),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isLoading)
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: textColor ?? AppColors.textPrimaryLight,
                      strokeWidth: 2.5,
                    ),
                  )
                else ...[
                  if (icon != null) ...[
                    icon!,
                    const SizedBox(width: 12),
                  ],
                  Text(
                    text,
                    style: TextStyle(
                      color: textColor ?? AppColors.textPrimaryLight,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
