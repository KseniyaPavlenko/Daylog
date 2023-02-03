import 'package:daylog/common/net/dio_interceptor.dart';
import 'package:daylog/cubits/auth/auth_cubit.dart';
import 'package:daylog/cubits/draft_detail/draft_detail_cubit.dart';
import 'package:daylog/cubits/draft_list/draft_list_cubit.dart';
import 'package:daylog/cubits/event_detail/event_detail_cubit.dart';
import 'package:daylog/cubits/event_list/event_list_cubit.dart';
import 'package:daylog/cubits/me/me_cubit.dart';
import 'package:daylog/env_config.dart';
import 'package:daylog/services/auth/auth_service.dart';
import 'package:daylog/services/auth/auth_service_mock.dart';
import 'package:daylog/services/draft/draft_service.dart';
import 'package:daylog/services/draft/draft_service_mock.dart';
import 'package:daylog/services/event/event_service.dart';
import 'package:daylog/services/event/event_service_mock.dart';
import 'package:daylog/services/local_storage/local_storage.dart';
import 'package:daylog/services/local_storage/local_storage_impl.dart';
import 'package:daylog/services/user/user_service.dart';
import 'package:daylog/services/user/user_service_mock.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupDi() {
  // Event
  getIt.registerLazySingleton<EventService>(() => EventServiceMock());
  getIt.registerFactory<EventListCubit>(
      () => EventListCubit(eventService: getIt()));
  getIt.registerFactory<EventDetailCubit>(
      () => EventDetailCubit(eventService: getIt()));
  // Draft
  getIt.registerLazySingleton<DraftService>(() => DraftServiceMock());
  getIt.registerFactory<DraftListCubit>(
      () => DraftListCubit(draftService: getIt()));
  getIt.registerFactory<DraftDetailCubit>(
      () => DraftDetailCubit(draftService: getIt()));
//Auth
  getIt.registerLazySingleton<AuthService>(() => AuthServiceMock());
  getIt.registerFactory<AuthCubit>(() => AuthCubit(authService: getIt()));
//User
  getIt.registerLazySingleton<UserService>(() => UserServiceMock());
  getIt.registerFactory<MeCubit>(() => MeCubit(userService: getIt()));

  _setupDio();
}

void _setupDio() {
  final envConfig = EnvConfig.local();
  final dio = Dio();
  dio.options.baseUrl = envConfig.baseUrl;

  getIt.registerLazySingleton<LocalStorage>(() => LocalStorageImlp());
  dio.interceptors.add(DioInterceptor(getIt()));
  getIt.registerLazySingleton<Dio>(() => dio);
}
