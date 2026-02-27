import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/services/image_picker/image_picker_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

/// Profile screen showing user info
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _selectedImage;
  bool _isUploading = false;
  double _uploadProgress = 0;

  Future<void> _pickAndUploadImage() async {
    final imageService = context.read<ImagePickerService>();
    
    final image = await imageService.pickFromGallery();
    if (image == null) return;

    setState(() {
      _selectedImage = image;
      _isUploading = true;
    });

    try {
      final result = await imageService.uploadImage(
        image,
        onProgress: (progress) {
          setState(() {
            _uploadProgress = progress;
          });
        },
      );

      if (result.success && mounted) {
        context.showSuccessSnackBar('Profile picture updated!');
      } else if (mounted) {
        context.showErrorSnackBar(result.error ?? 'Upload failed');
      }
    } catch (e) {
      if (mounted) {
        context.showErrorSnackBar(e.toString());
      }
    } finally {
      if (mounted) {
        setState(() {
          _isUploading = false;
          _uploadProgress = 0;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.connectSphere,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
        ),
      ),
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          final user = authProvider.user;
          
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // Profile picture with upload
                _buildProfilePicture(user?.displayName ?? 'User'),
                
                const SizedBox(height: 24),
                
                // User name
                Text(
                  user?.displayName ?? 'User',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                
                const SizedBox(height: 8),
                
                // Email
                Text(
                  user?.email ?? 'guest@socialhub.com',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondaryLight,
                      ),
                ),
                
                const SizedBox(height: 24),
                
                // Stats row
                _buildStatsRow(user?.memberSince),
                
                const SizedBox(height: 32),
                
                // Card with menu options
                _buildMenuCard(context),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfilePicture(String name) {
    return Stack(
      children: [
        // Avatar
        GestureDetector(
          onTap: _pickAndUploadImage,
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary,
              image: _selectedImage != null
                  ? DecorationImage(
                      image: FileImage(_selectedImage!),
                      fit: BoxFit.cover,
                    )
                  : null,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: _selectedImage == null
                ? Center(
                    child: Text(
                      name.isNotEmpty ? name[0].toUpperCase() : 'U',
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                  )
                : null,
          ),
        ),
        
        // Upload progress overlay
        if (_isUploading)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.black.withValues(alpha: 0.5),
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(
                      value: _uploadProgress,
                      color: AppColors.white,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${(_uploadProgress * 100).toInt()}%',
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        
        // Edit button
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.white,
            ),
            child: const Icon(
              Icons.camera_alt,
              size: 20,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatsRow(DateTime? memberSince) {
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                   'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    final memberDate = memberSince ?? DateTime.now();
    final memberString = "${months[memberDate.month - 1]} '${memberDate.year.toString().substring(2)}";

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.grey100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatItem('Posts', '12'),
          _buildVerticalDivider(),
          _buildStatItem(AppStrings.member, memberString),
          _buildVerticalDivider(),
          _buildStatItem(AppStrings.type, 'Google'),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textSecondaryLight,
              ),
        ),
      ],
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      width: 1,
      height: 40,
      color: AppColors.grey300,
    );
  }

  Widget _buildMenuCard(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              AppStrings.cardWith,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppColors.textSecondaryLight,
                  ),
            ),
          ),
          const Divider(height: 1),
          _buildMenuItem(
            icon: Icons.article_outlined,
            title: AppStrings.myPosts,
            onTap: () => context.goNamed(RouteNames.posts),
          ),
          _buildMenuItem(
            icon: Icons.edit_outlined,
            title: AppStrings.editProfile,
            onTap: () {
              // TODO: Implement edit profile
            },
          ),
          _buildMenuItem(
            icon: Icons.settings_outlined,
            title: AppStrings.settings,
            onTap: () => context.goNamed(RouteNames.settings),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right, color: AppColors.grey400),
      onTap: onTap,
    );
  }
}
