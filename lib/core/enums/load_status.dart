// =============================================================================
// Task 6.3 Step 3: Add bool isLoading, String? error - using LoadStatus enum
// Task 6.3 Step 5: Implement fetchUsers() setting states
// =============================================================================

/// Enum representing different loading states
enum LoadStatus {
  initial,
  loading,
  success,
  error,
  loadingMore,
}

/// Extension methods for LoadStatus
extension LoadStatusExtension on LoadStatus {
  bool get isInitial => this == LoadStatus.initial;
  bool get isLoading => this == LoadStatus.loading;
  bool get isSuccess => this == LoadStatus.success;
  bool get isError => this == LoadStatus.error;
  bool get isLoadingMore => this == LoadStatus.loadingMore;
  
  bool get isLoadingOrLoadingMore => isLoading || isLoadingMore;
}
