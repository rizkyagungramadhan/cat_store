import 'package:cat_store/api/client/dio_client.dart';
import 'package:cat_store/api/client/dio_client_impl.dart';
import 'package:cat_store/api/user/user_repository.dart';
import 'package:cat_store/api/user/user_repository_impl.dart';
import 'package:cat_store/module/home/home_view_model.dart';
import 'package:cat_store/module/login/login_view_model.dart';
import 'package:cat_store/module/onboarding/onboarding_view_model.dart';
import 'package:cat_store/module/splash/splash_view_model.dart';
import 'package:cat_store/service/prefs_service/prefs_service.dart';
import 'package:cat_store/service/prefs_service/prefs_service_impl.dart';
import 'package:cat_store/utility/route/app_router.dart';
import 'package:get_it/get_it.dart';

GetIt serviceLocator = GetIt.instance;

/// Inject all dependencies
void setupServiceLocator() {
  _registerServices();
  _registerViewModels();
  _registerAppDependencies();
  _registerRepositories();
}

void _registerRepositories() {
  serviceLocator.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(),
  );
}

void _registerServices() {
  serviceLocator.registerLazySingleton<PrefsService>(() => PrefsServiceImpl());
}

void _registerViewModels() {
  serviceLocator.registerFactory<HomeViewModel>(() => HomeViewModel());
  serviceLocator.registerFactory<LoginViewModel>(() => LoginViewModel());
  serviceLocator
      .registerFactory<OnBoardingViewModel>(() => OnBoardingViewModel());
  serviceLocator.registerFactory<SplashViewModel>(() => SplashViewModel());
}

void _registerAppDependencies() {
  serviceLocator.registerLazySingleton<AppRouter>(() => AppRouter());
  serviceLocator.registerLazySingleton<DioClient>(
    () => DioClientImpl.initialize(),
  );
}
