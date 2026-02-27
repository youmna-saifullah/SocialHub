import 'package:flutter/foundation.dart';

import '../../../../core/config/app_config.dart';
import '../../../../core/enums/load_status.dart';
import '../../domain/entities/api_user_entity.dart';
import '../../domain/usecases/get_users_usecase.dart';

// =============================================================================
// Task 6.3 Step 2: Create UserProvider extends ChangeNotifier
// Task 6.3 Step 3: Add List<User> users, bool isLoading, String? error
// Task 6.3 Step 11: Add pagination with ScrollController
// Task 6.3 Step 12: Implement search filtering users list
// =============================================================================

/// Provider for users state management with pagination and search
class UsersProvider extends ChangeNotifier {
  final GetUsersUseCase _getUsersUseCase;

  UsersProvider({
    required GetUsersUseCase getUsersUseCase,
  }) : _getUsersUseCase = getUsersUseCase;

  // Task 6.3 Step 3: Add List<User> users, bool isLoading, String? error
  // State
  List<ApiUserEntity> _allUsers = [];
  List<ApiUserEntity> _displayedUsers = [];
  LoadStatus _loadStatus = LoadStatus.initial;
  String? _error;
  bool _isRefreshing = false;
  String _searchQuery = '';
  
  // Task 6.3 Step 11: Pagination state
  int _currentPage = 1;
  bool _hasMoreData = true;
  final int _pageSize = AppConfig.defaultPageSize;

  // Getters
  List<ApiUserEntity> get users => _displayedUsers;
  LoadStatus get loadStatus => _loadStatus;
  String? get error => _error;
  bool get isLoading => _loadStatus == LoadStatus.loading;
  bool get isLoadingMore => _loadStatus == LoadStatus.loadingMore;
  bool get isRefreshing => _isRefreshing;
  bool get hasMoreData => _hasMoreData;
  String get searchQuery => _searchQuery;

  // Task 6.3 Step 5: Implement fetchUsers() setting states
  // Task 6.3 Step 6: Use notifyListeners() after state changes
  /// Fetch all users
  Future<void> fetchUsers() async {
    if (_loadStatus == LoadStatus.loading) return;

    _loadStatus = LoadStatus.loading;
    _error = null;
    _currentPage = 1;
    notifyListeners();

    try {
      _allUsers = await _getUsersUseCase();
      _applyFiltersAndPagination();
      _loadStatus = LoadStatus.success;
    } catch (e) {
      _error = e.toString();
      _loadStatus = LoadStatus.error;
    }
    notifyListeners();
  }

  // Task 6.3 Step 10: Implement RefreshIndicator with onRefresh
  /// Refresh users (pull-to-refresh)
  Future<void> refreshUsers() async {
    _isRefreshing = true;
    notifyListeners();

    try {
      _allUsers = await _getUsersUseCase();
      _currentPage = 1;
      _applyFiltersAndPagination();
      _error = null;
    } catch (e) {
      _error = e.toString();
    }
    
    _isRefreshing = false;
    notifyListeners();
  }

  // Task 6.3 Step 11: Add pagination - Load more users
  /// Load more users (pagination)
  Future<void> loadMoreUsers() async {
    if (_loadStatus == LoadStatus.loadingMore || !_hasMoreData) return;

    _loadStatus = LoadStatus.loadingMore;
    notifyListeners();

    // Simulate network delay for smooth UX
    await Future.delayed(const Duration(milliseconds: 500));

    _currentPage++;
    _applyFiltersAndPagination();
    
    _loadStatus = LoadStatus.success;
    notifyListeners();
  }

  // Task 6.3 Step 12: Implement search filtering users list
  /// Search users by query
  void searchUsers(String query) {
    _searchQuery = query;
    _currentPage = 1;
    _applyFiltersAndPagination();
    notifyListeners();
  }

  /// Clear search
  void clearSearch() {
    _searchQuery = '';
    _currentPage = 1;
    _applyFiltersAndPagination();
    notifyListeners();
  }

  // Task 6.3 Step 12: Apply filters and pagination to the user list
  /// Apply filters and pagination to the user list
  void _applyFiltersAndPagination() {
    List<ApiUserEntity> filtered = _allUsers;

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      final lowercaseQuery = _searchQuery.toLowerCase();
      filtered = _allUsers.where((user) {
        return user.name.toLowerCase().contains(lowercaseQuery) ||
               user.email.toLowerCase().contains(lowercaseQuery) ||
               user.username.toLowerCase().contains(lowercaseQuery);
      }).toList();
    }

    // Apply pagination
    final totalItems = filtered.length;
    final endIndex = _currentPage * _pageSize;
    
    _hasMoreData = endIndex < totalItems;
    
    _displayedUsers = filtered.take(endIndex).toList();
  }

  /// Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }
}
