import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/router/app_router.dart';
import '../core/services/image_picker/image_picker_service.dart';
import '../core/services/local_storage/local_storage_service.dart';
import '../core/theme/app_theme.dart';
import '../features/auth/presentation/providers/auth_provider.dart';
import '../features/posts/presentation/providers/posts_provider.dart';
import '../features/settings/presentation/providers/settings_provider.dart';
import '../features/users/presentation/providers/users_provider.dart';
import 'injection_container.dart';

/// Root widget of the SocialHub application
class SocialHubApp extends StatelessWidget {
  const SocialHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Core Services
        Provider<LocalStorageService>.value(
          value: getIt<LocalStorageService>(),
        ),
        Provider<ImagePickerService>.value(
          value: getIt<ImagePickerService>(),
        ),
        
        // Auth Provider
        ChangeNotifierProvider<AuthProvider>.value(
          value: getIt<AuthProvider>(),
        ),
        
        // Posts Provider
        ChangeNotifierProvider<PostsProvider>.value(
          value: getIt<PostsProvider>(),
        ),
        
        // Users Provider
        ChangeNotifierProvider<UsersProvider>.value(
          value: getIt<UsersProvider>(),
        ),
        
        // Settings Provider
        ChangeNotifierProvider<SettingsProvider>.value(
          value: getIt<SettingsProvider>(),
        ),
      ],
      child: Consumer<SettingsProvider>(
        builder: (context, settingsProvider, child) {
          final router = getIt<AppRouter>().router;
          
          return MaterialApp.router(
            title: 'SocialHub',
            debugShowCheckedModeBanner: false,
            
            // Theme configuration
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: settingsProvider.themeMode,
            
            // GoRouter configuration
            routerConfig: router,
          );
        },
      ),
    );
  }
}
