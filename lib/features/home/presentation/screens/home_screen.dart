import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../posts/presentation/screens/posts_screen.dart';

/// Home screen with bottom navigation
class HomeScreen extends StatefulWidget {
  final Widget child;

  const HomeScreen({
    super.key,
    required this.child,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<_NavItem> _navItems = const [
    _NavItem(
      icon: Icons.article_outlined,
      activeIcon: Icons.article,
      label: AppStrings.posts,
      route: RouteNames.posts,
    ),
    _NavItem(
      icon: Icons.people_outline,
      activeIcon: Icons.people,
      label: AppStrings.users,
      route: RouteNames.users,
    ),
    _NavItem(
      icon: Icons.person_outline,
      activeIcon: Icons.person,
      label: AppStrings.profile,
      route: RouteNames.profile,
    ),
    _NavItem(
      icon: Icons.settings_outlined,
      activeIcon: Icons.settings,
      label: AppStrings.settings,
      route: RouteNames.settings,
    ),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateCurrentIndex();
  }

  void _updateCurrentIndex() {
    final location = GoRouterState.of(context).uri.toString();
    final index = _navItems.indexWhere(
      (item) => location.startsWith('/${item.route.replaceAll('-', '')}') ||
                location.startsWith('/${item.route}'),
    );
    if (index != -1 && index != _currentIndex) {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  void _onItemTapped(int index) {
    if (index != _currentIndex) {
      setState(() {
        _currentIndex = index;
      });
      context.goNamed(_navItems[index].route);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Determine which content to show based on current route
    final location = GoRouterState.of(context).uri.toString();
    final Widget content;
    
    if (location.startsWith('/posts')) {
      content = const PostsScreen();
    } else {
      content = widget.child;
    }

    return Scaffold(
      body: content,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(_navItems.length, (index) {
                final item = _navItems[index];
                final isSelected = index == _currentIndex;
                
                return _buildNavItem(
                  icon: isSelected ? item.activeIcon : item.icon,
                  label: item.label,
                  isSelected: isSelected,
                  onTap: () => _onItemTapped(index),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.primary : AppColors.grey500,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppColors.primary : AppColors.grey500,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final String route;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.route,
  });
}
