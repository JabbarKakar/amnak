import 'package:amnak/features/courses/domain/usecases/usecases.dart';
import 'package:amnak/features/courses/presentation/cubit.dart';
import 'package:amnak/features/courses/presentation/lecturess_cubit.dart';
import 'package:dio/dio.dart';
import 'package:amnak/core/feature/data/datasources/secure_local_data_source.dart';
import 'package:amnak/core/feature/data/repositories/repository_imp.dart';
import 'package:amnak/core/feature/domain/repositories/repositories.dart';
import 'package:amnak/core/network/auth_interceptor.dart';
import 'package:amnak/core/network/network.dart';
import 'package:amnak/export.dart';
import 'package:amnak/features/auth/domain/usecases/usecases.dart';
import 'package:amnak/features/auth/presentation/cubit.dart';
import 'package:amnak/features/auth/presentation/reset_pass_cubit.dart';
import 'package:amnak/features/auth/presentation/settings/profile/profile_cubit.dart';
import 'package:amnak/features/auth/presentation/settings/profile/update_pass/update_pass_cubit.dart';
import 'package:amnak/features/chats/domain/usecases/usecases.dart';
import 'package:amnak/features/chats/presentation/chat_conversations_cubit.dart';
import 'package:amnak/features/chats/presentation/chat_details_cubit.dart';
import 'package:amnak/features/chats/presentation/chat_persons_cubit.dart';
import 'package:amnak/features/home/presentation/home_cubit.dart';
import 'package:amnak/features/notifications/domain/usecases/usecases.dart';
import 'package:amnak/features/notifications/presentation/cubit.dart';
import 'package:amnak/features/notifications/presentation/instructions_cubit.dart';
import 'package:amnak/features/post/domain/usecases/post.dart';
import 'package:amnak/features/projects/domain/usecases/usecases.dart';
import 'package:amnak/features/projects/presentation/projects_cubit.dart';
import 'package:amnak/features/terms_privacy/domain/usecases/usecases.dart';
import 'package:amnak/features/terms_privacy/presentation/cubit.dart';
import 'package:amnak/features/visitors/domain/usecases/usecases.dart';
import 'package:amnak/features/visitors/presentation/visitors_cubit.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:requests_inspector/requests_inspector.dart';

import '../features/post/data/datasources/post_local_data_source.dart';
import '../features/post/data/repositories/post_repository_impl.dart';
import '../features/post/domain/repositories/posts_repository.dart';
import '../features/post/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import '../features/post/presentation/bloc/posts/posts_bloc.dart';
import 'network/network_info.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features
  sl.registerLazySingleton(() => ProfileCubit(useCase: sl(), box: sl()));
  // Bloc
  sl.registerFactory(() => PostsBloc(postUseCases: sl()));
  sl.registerFactory(() => AddDeleteUpdatePostBloc(postUseCases: sl()));
  sl.registerFactory(() => AuthCubit(useCase: sl(), box: sl()));
  sl.registerFactory(() => ResetPassCubit(useCase: sl()));
  sl.registerFactory(() => ProjectsCubit(useCase: sl()));
  sl.registerFactory(() => UpdatePassCubit(useCase: sl()));
  sl.registerFactory(() => VisitorsCubit(useCase: sl()));
  sl.registerFactory(() => ChatPersonsCubit(useCase: sl()));
  sl.registerFactory(() => ChatConversationsCubit(useCase: sl()));
  sl.registerFactory(() => ChatDetailsCubit(useCase: sl()));
  sl.registerFactory(() => TermsCubit(useCase: sl()));
  sl.registerFactory(() => HomeCubit(useCase: sl()));
  sl.registerFactory(() => NotificationsCubit(useCase: sl()));
  sl.registerFactory(() => InstructionsCubit(useCase: sl()));
  sl.registerFactory(() => CoursesCubit(useCase: sl()));
  sl.registerFactory(() => LecturesCubit(useCase: sl()));

  // Usecases
  sl.registerLazySingleton(() => PostUsecases(sl()));
  sl.registerLazySingleton(() => ProjectsUseCase(repository: sl()));
  sl.registerLazySingleton(() => VisitorsUseCase(repository: sl()));
  sl.registerLazySingleton(() => UserUseCase(repository: sl()));
  sl.registerLazySingleton(() => ChatsUseCase(repository: sl()));
  sl.registerLazySingleton(() => TermsUseCase(repository: sl()));
  sl.registerLazySingleton(() => NotificationsUseCase(repository: sl()));
  sl.registerLazySingleton(() => CoursesUseCase(repository: sl()));

  // Repository
  sl.registerLazySingleton<PostsRepository>(
      () => PostsRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()));
  sl.registerLazySingleton<Repository>(
      () => RepoImp(remoteDataSource: sl(), localDataSource: sl()));

  // Datasources
  sl.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSource(network: sl(), networkInfo: sl()));
  sl.registerLazySingleton<PostLocalDataSource>(
      () => PostLocalDataSourceImpl(sharedPreferences: sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<Network>(() => Network(dio: sl(), box: sl()));
  sl.registerLazySingleton(() => SecureLocalDataSourceImpl(box: sl()));
  sl.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImpl(box: sl()));

  //! External
  sl.registerLazySingleton(() => GetStorage());
  sl.registerLazySingleton(() => const FlutterSecureStorage());

  sl.registerLazySingleton(() => InternetConnectionChecker());

  sl.registerLazySingleton<Dio>(() => Dio(BaseOptions(
        connectTimeout: const Duration(seconds: 1000),
        receiveTimeout: const Duration(seconds: 1000),
        // By default, Dio treats any HTTP status code from 200 to 299 as a successful response. If you need a different range or specific conditions, you can override it using validateStatus.
        validateStatus: (status) {
          // Treat status codes less than 399 as successful
          return status != null;
        },
      )));
  sl<Dio>().interceptors.addAll(
    [
      AuthInterceptor(dio: sl(), authCubit: sl(), box: sl()),
      RequestsInspectorInterceptor(),
    ],
  );
}
