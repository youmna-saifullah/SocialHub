import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/enums/load_status.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/inputs/search_text_field.dart';
import '../../../../core/widgets/loaders/shimmer_loading.dart';
import '../../../../core/widgets/more/state_widgets.dart';
import '../providers/users_provider.dart';
import '../widgets/user_tile.dart';

// =============================================================================
// Task 6.3 Step 7: Create UsersPage with Consumer
// Task 6.3 Step 8: Show loading indicator when isLoading
// Task 6.3 Step 9: Display error with error widget
// Task 6.3 Step 10: Implement RefreshIndicator with onRefresh
// Task 6.3 Step 11: Add pagination with ScrollController
// Task 6.3 Step 12: Implement search filtering users list
// =============================================================================

/// Users screen with search and pagination
class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  // Task 6.3 Step 12: Search text controller
  final TextEditingController _searchController = TextEditingController();
  // Task 6.3 Step 11: Add pagination with ScrollController
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadUsers();
    });
    _scrollController.addListener(_onScroll);
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _loadUsers() {
    final provider = context.read<UsersProvider>();
    if (provider.loadStatus == LoadStatus.initial) {
      provider.fetchUsers();
    }
  }

  // Task 6.3 Step 11: Add pagination with ScrollController - scroll listener
  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<UsersProvider>().loadMoreUsers();
    }
  }

  // Task 6.3 Step 12: Implement search filtering users list
  void _onSearchChanged() {
    context.read<UsersProvider>().searchUsers(_searchController.text);
  }

  // Task 6.3 Step 10: Implement RefreshIndicator with onRefresh
  Future<void> _refreshUsers() async {
    await context.read<UsersProvider>().refreshUsers();
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
      // Task 6.3 Step 7: Create UsersPage with Consumer
      body: Consumer<UsersProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              // Task 6.3 Step 12: Search bar for filtering
              Padding(
                padding: const EdgeInsets.all(16),
                child: SearchTextField(
                  controller: _searchController,
                  hint: AppStrings.searchUsers,
                  onClear: () {
                    _searchController.clear();
                    provider.clearSearch();
                  },
                ),
              ),

              // Header with labels
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppStrings.userTiles,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.search,
                            size: 16,
                            color: AppColors.primary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Search TextField',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              // User list
              Expanded(
                child: _buildUserList(provider),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildUserList(UsersProvider provider) {
    // Task 6.3 Step 8: Show loading indicator when isLoading
    if (provider.loadStatus == LoadStatus.loading && provider.users.isEmpty) {
      return _buildLoadingState();
    }

    // Task 6.3 Step 9: Display error with error widget
    if (provider.loadStatus == LoadStatus.error && provider.users.isEmpty) {
      return ErrorStateWidget(
        message: provider.error,
        onRetry: () => provider.fetchUsers(),
      );
    }

    if (provider.users.isEmpty) {
      return const EmptyStateWidget(
        message: AppStrings.noUsersFound,
        icon: Icons.people_outline,
      );
    }

    // Task 6.3 Step 10: Implement RefreshIndicator with onRefresh
    return RefreshIndicator(
      onRefresh: _refreshUsers,
      // Task 6.1 Step 12: Display users in ListView.builder()
      child: ListView.builder(
        // Task 6.3 Step 11: Add pagination with ScrollController
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: provider.users.length + (provider.hasMoreData ? 1 : 0) + 1,
        itemBuilder: (context, index) {
          // Info labels at the top
          if (index == 0) {
            return _buildInfoLabels();
          }
          
          // Adjust index for info labels
          final adjustedIndex = index - 1;
          
          // Task 6.3 Step 11: Loading indicator for pagination
          if (adjustedIndex >= provider.users.length) {
            return _buildLoadMoreIndicator(provider);
          }

          // User tile
          final user = provider.users[adjustedIndex];
          return UserTile(user: user);
        },
      ),
    );
  }

  Widget _buildInfoLabels() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          _buildInfoChip(
            icon: Icons.refresh,
            label: AppStrings.pullToRefresh,
          ),
          const SizedBox(width: 8),
          const Text('+', style: TextStyle(color: AppColors.grey500)),
          const SizedBox(width: 8),
          _buildInfoChip(
            icon: Icons.arrow_downward,
            label: AppStrings.infiniteScroll,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip({required IconData icon, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.grey100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.grey600),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.grey600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 10,
      itemBuilder: (context, index) => const UserTileSkeleton(),
    );
  }

  Widget _buildLoadMoreIndicator(UsersProvider provider) {
    if (provider.isLoadingMore) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
