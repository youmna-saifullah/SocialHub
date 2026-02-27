import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/router/app_router.dart';
import '../core/services/dio/dio_client.dart';
import '../core/services/image_picker/image_picker_service.dart';
import '../core/services/local_storage/local_storage_service.dart';
import '../core/services/logger/logger_service.dart';
import '../core/services/network/network_info.dart';
import '../features/auth/data/datasources/auth_local_data_source.dart';
import '../features/auth/data/datasources/auth_remote_data_source.dart';
import '../features/auth/data/repositories/auth_repository_impl.dart';
import '../features/auth/domain/repositories/auth_repository.dart';
import '../features/auth/domain/usecases/sign_in_as_guest_usecase.dart';
import '../features/auth/domain/usecases/sign_in_with_google_usecase.dart';
import '../features/auth/domain/usecases/sign_out_usecase.dart';
import '../features/auth/presentation/providers/auth_provider.dart';
import '../features/posts/data/datasources/post_remote_data_source.dart';
import '../features/posts/data/repositories/post_repository_impl.dart';
import '../features/posts/domain/repositories/post_repository.dart';
import '../features/posts/domain/usecases/create_post_usecase.dart';
import '../features/posts/domain/usecases/delete_post_usecase.dart';
import '../features/posts/domain/usecases/get_posts_usecase.dart';
import '../features/posts/domain/usecases/update_post_usecase.dart';
import '../features/posts/presentation/providers/posts_provider.dart';
import '../features/settings/presentation/providers/settings_provider.dart';
import '../features/users/data/datasources/user_remote_data_source.dart';
import '../features/users/data/repositories/user_repository_impl.dart';
import '../features/users/domain/repositories/user_repository.dart';
import '../features/users/domain/usecases/get_users_usecase.dart';
import '../features/users/presentation/providers/users_provider.dart';

/// Global GetIt instance
final getIt = GetIt.instance;

/// Initialize all dependencies
Future<void> initializeDependencies() async {
  // External dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  // Core Services
  _registerCoreServices();

  // Features
  _registerAuthFeature();
  _registerPostsFeature();
  _registerUsersFeature();
  _registerSettingsFeature();

  // Router
  getIt.registerLazySingleton<AppRouter>(
    () => AppRouter(localStorage: getIt<LocalStorageService>()),
  );
}

void _registerCoreServices() {
  // Logger
  getIt.registerLazySingleton<LoggerService>(() => LoggerService());

  // Local Storage
  getIt.registerLazySingleton<LocalStorageService>(
    () => LocalStorageService(prefs: getIt<SharedPreferences>()),
  );

  // Network Info
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

  // Dio Client
  getIt.registerLazySingleton<DioClient>(
    () => DioClient(
      logger: getIt<LoggerService>(),
      localStorage: getIt<LocalStorageService>(),
      networkInfo: getIt<NetworkInfo>(),
    ),
  );

  // Image Picker Service
  getIt.registerLazySingleton<ImagePickerService>(
    () => ImagePickerService(dioClient: getIt<DioClient>()),
  );
}

void _registerAuthFeature() {
  // Data Sources
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );
  getIt.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(localStorage: getIt<LocalStorageService>()),
  );

  // Repository
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: getIt<AuthRemoteDataSource>(),
      localDataSource: getIt<AuthLocalDataSource>(),
    ),
  );

  // Use Cases
  getIt.registerLazySingleton<SignInWithGoogleUseCase>(
    () => SignInWithGoogleUseCase(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<SignInAsGuestUseCase>(
    () => SignInAsGuestUseCase(getIt<AuthRepository>()),
  );
  getIt.registerLazySingleton<SignOutUseCase>(
    () => SignOutUseCase(getIt<AuthRepository>()),
  );

  // Provider
  getIt.registerLazySingleton<AuthProvider>(
    () => AuthProvider(
      signInWithGoogleUseCase: getIt<SignInWithGoogleUseCase>(),
      signInAsGuestUseCase: getIt<SignInAsGuestUseCase>(),
      signOutUseCase: getIt<SignOutUseCase>(),
      authRepository: getIt<AuthRepository>(),
    ),
  );
}

void _registerPostsFeature() {
  // Data Source
  getIt.registerLazySingleton<PostRemoteDataSource>(
    () => PostRemoteDataSourceImpl(dioClient: getIt<DioClient>()),
  );

  // Repository
  getIt.registerLazySingleton<PostRepository>(
    () => PostRepositoryImpl(remoteDataSource: getIt<PostRemoteDataSource>()),
  );

  // Use Cases
  getIt.registerLazySingleton<GetPostsUseCase>(
    () => GetPostsUseCase(getIt<PostRepository>()),
  );
  getIt.registerLazySingleton<CreatePostUseCase>(
    () => CreatePostUseCase(getIt<PostRepository>()),
  );
  getIt.registerLazySingleton<UpdatePostUseCase>(
    () => UpdatePostUseCase(getIt<PostRepository>()),
  );
  getIt.registerLazySingleton<DeletePostUseCase>(
    () => DeletePostUseCase(getIt<PostRepository>()),
  );

  // Provider
  getIt.registerLazySingleton<PostsProvider>(
    () => PostsProvider(
      getPostsUseCase: getIt<GetPostsUseCase>(),
      createPostUseCase: getIt<CreatePostUseCase>(),
      updatePostUseCase: getIt<UpdatePostUseCase>(),
      deletePostUseCase: getIt<DeletePostUseCase>(),
    ),
  );
}

void _registerUsersFeature() {
  // Data Source
  getIt.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(dioClient: getIt<DioClient>()),
  );

  // Repository
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(remoteDataSource: getIt<UserRemoteDataSource>()),
  );

  // Use Cases
  getIt.registerLazySingleton<GetUsersUseCase>(
    () => GetUsersUseCase(getIt<UserRepository>()),
  );

  // Provider
  getIt.registerLazySingleton<UsersProvider>(
    () => UsersProvider(
      getUsersUseCase: getIt<GetUsersUseCase>(),
    ),
  );
}

void _registerSettingsFeature() {
  // Provider
  getIt.registerLazySingleton<SettingsProvider>(
    () => SettingsProvider(localStorage: getIt<LocalStorageService>()),
  );
}
