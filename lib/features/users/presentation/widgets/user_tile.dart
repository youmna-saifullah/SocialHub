import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/api_user_entity.dart';

/// User tile widget for displaying a single user
class UserTile extends StatelessWidget {
  final ApiUserEntity user;
  final VoidCallback? onTap;

  const UserTile({
    super.key,
    required this.user,
    this.onTap,
  });

  // Avatar colors palette
  static const List<Color> _avatarColors = [
    Color(0xFF4A90E2),
    Color(0xFF9B59B6),
    Color(0xFF27AE60),
    Color(0xFFE74C3C),
    Color(0xFFF39C12),
    Color(0xFF1ABC9C),
  ];

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        radius: 24,
        backgroundColor: _avatarColors[user.avatarColorIndex],
        child: Text(
          user.initials,
          style: const TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      title: Text(
        user.name,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
      ),
      subtitle: Text(
        user.email,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondaryLight,
            ),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: AppColors.grey400,
      ),
    );
  }
}
