import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/dialogs/confirm_dialog.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../providers/settings_provider.dart';

/// Settings screen with theme toggle and logout
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.settingsPage,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: Consumer<SettingsProvider>(
        builder: (context, settingsProvider, child) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Dark Mode toggle
              _buildSettingsTile(
                context,
                icon: Icons.dark_mode_outlined,
                title: AppStrings.darkMode,
                trailing: Switch(
                  value: settingsProvider.isDarkMode,
                  onChanged: (value) => settingsProvider.toggleDarkMode(),
                ),
              ),

              // Notifications toggle
              _buildSettingsTile(
                context,
                icon: Icons.notifications_outlined,
                title: AppStrings.notifications,
                trailing: Switch(
                  value: settingsProvider.notificationsEnabled,
                  onChanged: (value) => settingsProvider.toggleNotifications(),
                ),
              ),

              // Clear Cache
              _buildSettingsTile(
                context,
                icon: Icons.delete_outline,
                title: AppStrings.clearCache,
                onTap: () => _handleClearCache(context, settingsProvider),
              ),

              const SizedBox(height: 16),

              // Logout
              _buildSettingsTile(
                context,
                icon: Icons.logout,
                title: AppStrings.logout,
                iconColor: AppColors.error,
                titleColor: AppColors.error,
                subtitle: '(Red)',
                onTap: () => _handleLogout(context),
              ),

              const SizedBox(height: 16),

              // About App
              _buildSettingsTile(
                context,
                icon: Icons.info_outline,
                title: AppStrings.aboutApp,
                onTap: () => _showAboutDialog(context),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSettingsTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
    Color? iconColor,
    Color? titleColor,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(
          icon,
          color: iconColor ?? AppColors.primary,
        ),
        title: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                color: titleColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (subtitle != null) ...[
              const SizedBox(width: 4),
              Text(
                subtitle,
                style: TextStyle(
                  color: titleColor ?? AppColors.textSecondaryLight,
                  fontSize: 12,
                ),
              ),
            ],
          ],
        ),
        trailing: trailing ??
            const Icon(Icons.chevron_right, color: AppColors.grey400),
        onTap: onTap,
      ),
    );
  }

  Future<void> _handleClearCache(
    BuildContext context,
    SettingsProvider provider,
  ) async {
    final confirmed = await ConfirmDialog.show(
      context,
      title: AppStrings.clearCache,
      message: 'Are you sure you want to clear the cache?',
      confirmText: 'Clear',
      cancelText: AppStrings.cancel,
    );

    if (confirmed == true) {
      if (!context.mounted) return;
      await provider.clearCache();
      if (!context.mounted) return;
      context.showSuccessSnackBar('Cache cleared successfully');
    }
  }

  Future<void> _handleLogout(BuildContext context) async {
    final confirmed = await ConfirmDialog.show(
      context,
      title: AppStrings.logout,
      message: AppStrings.logoutConfirm,
      confirmText: AppStrings.logout,
      cancelText: AppStrings.cancel,
      isDestructive: true,
    );

    if (confirmed == true && context.mounted) {
      final authProvider = context.read<AuthProvider>();
      await authProvider.signOut();
      
      if (context.mounted) {
        context.goNamed(RouteNames.login);
      }
    }
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(AppStrings.appName),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Version 1.0.0',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'A social media app built with Flutter following Clean Architecture principles.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondaryLight,
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              'Features:',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            const Text('• Dio for API requests'),
            const Text('• Firebase Authentication'),
            const Text('• Provider State Management'),
            const Text('• GoRouter Navigation'),
            const Text('• Dark/Light Theme'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
