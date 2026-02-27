import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/enums/load_status.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/dialogs/confirm_dialog.dart';
import '../../../../core/widgets/loaders/shimmer_loading.dart';
import '../../../../core/widgets/more/state_widgets.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../providers/posts_provider.dart';
import '../widgets/post_card.dart';

// =============================================================================
// Task 6.1 Step 9: Create PostsPage with FutureBuilder (using Consumer with Provider)
// Task 6.1 Step 10: Handle ConnectionState.waiting with loading
// Task 6.1 Step 11: Handle errors with snapshot.hasError
// Task 6.1 Step 12: Display posts in ListView.builder()
// Task 6.2 Step 10: Show SnackBar with success/error message
// Task 6.2 Step 12: Handle delete with confirmation dialog
// Task 6.3 Step 7: Create UsersPage with Consumer
// =============================================================================

/// Posts screen showing list of posts
class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadPosts();
    });
  }

  void _loadPosts() {
    final provider = context.read<PostsProvider>();
    if (provider.loadStatus == LoadStatus.initial) {
      provider.fetchPosts();
    }
  }

  Future<void> _refreshPosts() async {
    await context.read<PostsProvider>().refreshPosts();
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
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: Implement search
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              context.goNamed(RouteNames.settings);
            },
          ),
        ],
      ),
      // Task 6.3 Step 7: Create PostsPage with Consumer<PostsProvider>
      body: Consumer<PostsProvider>(
        builder: (context, provider, child) {
          // Task 6.1 Step 10: Handle ConnectionState.waiting with loading
          // Task 6.3 Step 8: Show loading indicator when isLoading
          if (provider.loadStatus == LoadStatus.loading && 
              provider.posts.isEmpty) {
            return _buildLoadingState();
          }

          // Task 6.1 Step 11: Handle errors with snapshot.hasError
          // Task 6.3 Step 9: Display error with error widget
          if (provider.loadStatus == LoadStatus.error && 
              provider.posts.isEmpty) {
            return ErrorStateWidget(
              message: provider.error,
              onRetry: () => provider.fetchPosts(),
            );
          }

          if (provider.posts.isEmpty) {
            return const EmptyStateWidget(
              message: 'No posts yet',
              icon: Icons.article_outlined,
            );
          }

          // Task 6.3 Step 10: Implement RefreshIndicator with onRefresh
          return RefreshIndicator(
            onRefresh: _refreshPosts,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppStrings.postsList,
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
                              Icons.refresh,
                              size: 16,
                              color: AppColors.primary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'RefreshIndicator',
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
                Expanded(
                  // Task 6.1 Step 12: Display posts in ListView.builder()
                  child: ListView.builder(
                    padding: const EdgeInsets.only(bottom: 80),
                    itemCount: provider.posts.length,
                    itemBuilder: (context, index) {
                      final post = provider.posts[index];
                      return PostCard(
                        post: post,
                        onEdit: () => _editPost(post.id),
                        // Task 6.2 Step 12: Handle delete with confirmation dialog
                        onDelete: () => _deletePost(post.id),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.goNamed(RouteNames.createPost),
        icon: const Icon(Icons.add),
        label: const Text(AppStrings.createPost),
      ),
    );
  }

  Widget _buildLoadingState() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (context, index) => const PostCardSkeleton(),
    );
  }

  // Task 6.2 Step 11: Implement edit with pre-filled form
  void _editPost(int postId) {
    context.goNamed(
      RouteNames.editPost,
      pathParameters: {'postId': postId.toString()},
    );
  }

  // Task 6.2 Step 12: Handle delete with confirmation dialog
  Future<void> _deletePost(int postId) async {
    final confirmed = await ConfirmDialog.show(
      context,
      title: AppStrings.deleteConfirmTitle,
      message: AppStrings.deleteConfirmMessage,
      confirmText: AppStrings.delete,
      cancelText: AppStrings.cancel,
      isDestructive: true,
    );

    if (confirmed == true && mounted) {
      final provider = context.read<PostsProvider>();
      final success = await provider.deletePost(postId);
      
      // Task 6.2 Step 10: Show SnackBar with success/error message
      if (mounted) {
        if (success) {
          context.showSuccessSnackBar(AppStrings.postDeleted);
        } else {
          context.showErrorSnackBar(provider.error ?? AppStrings.errorOccurred);
        }
      }
    }
  }
}
