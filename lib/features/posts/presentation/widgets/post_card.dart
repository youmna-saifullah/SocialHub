import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/extensions/date_extensions.dart';
import '../../../../core/extensions/string_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/post_entity.dart';

/// Post card widget for displaying a single post
class PostCard extends StatelessWidget {
  final PostEntity post;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onTap;

  const PostCard({
    super.key,
    required this.post,
    this.onEdit,
    this.onDelete,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            _buildImage(),
            
            // Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    post.title.titleCase,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Body
                  Text(
                    post.body,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondaryLight,
                        ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Action buttons
                  Row(
                    children: [
                      _ActionChip(
                        icon: Icons.edit_outlined,
                        label: AppStrings.edit,
                        onTap: onEdit,
                      ),
                      const SizedBox(width: 8),
                      _ActionChip(
                        icon: Icons.delete_outline,
                        label: AppStrings.delete,
                        onTap: onDelete,
                        isDestructive: true,
                      ),
                      const SizedBox(width: 8),
                      _ActionChip(
                        icon: Icons.access_time,
                        label: post.createdAt?.timeAgo ?? AppStrings.time,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    // Use a placeholder image since JSONPlaceholder doesn't return images
    final imageUrl = post.imageUrl ?? 
        'https://picsum.photos/seed/${post.id}/400/200';
    
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        height: 180,
        width: double.infinity,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          height: 180,
          color: AppColors.grey200,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
        errorWidget: (context, url, error) => Container(
          height: 180,
          color: AppColors.grey200,
          child: const Icon(
            Icons.image_not_supported,
            size: 48,
            color: AppColors.grey400,
          ),
        ),
      ),
    );
  }
}

class _ActionChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final bool isDestructive;

  const _ActionChip({
    required this.icon,
    required this.label,
    this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isDestructive ? AppColors.error : AppColors.grey600;
    
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
