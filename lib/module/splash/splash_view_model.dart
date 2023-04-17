import 'package:cat_store/api/user/model/user_response.dart';
import 'package:cat_store/di/service_locator.dart';
import 'package:cat_store/service/prefs_service/prefs_service.dart';
import 'package:cat_store/utility/route/app_route.dart';
import 'package:cat_store/utility/route/app_router.dart';
import 'package:cat_store/utility/view_model_mixin.dart';
import 'package:flutter/material.dart';

class SplashViewModel extends ChangeNotifier with ViewModelMixin {
  final _appRouter = serviceLocator<AppRouter>();
  final _prefsService = serviceLocator<PrefsService>();

  Future<void> init() async {
    var routeTarget = Routes.onBoarding;

    try {
      /// Simulate takes some time when initializing app data
      await Future.delayed(const Duration(seconds: 2));

      final isUserLoggedIn = _isLoggedIn();

      if (isUserLoggedIn) {
        routeTarget = Routes.home;
      }
    } catch (error) {
      logError(error);
    } finally {
      return await _appRouter.rootClearAndNavigateTo(routeTarget);
    }
  }

  bool _isLoggedIn() {
    final userLogin = _prefsService.getUserLogin();
    return userLogin is UserResponse;
  }
}
