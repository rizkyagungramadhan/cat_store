import 'package:cat_store/di/service_locator.dart';
import 'package:cat_store/module/profile/profile_presentation.dart';
import 'package:cat_store/service/prefs_service/prefs_service.dart';
import 'package:cat_store/utility/route/app_route.dart';
import 'package:cat_store/utility/route/app_router.dart';
import 'package:cat_store/utility/view_model_mixin.dart';
import 'package:flutter/material.dart';

class ProfileViewModel extends ChangeNotifier with ViewModelMixin {
  final _prefsService = serviceLocator<PrefsService>();
  final _appRouter = serviceLocator<AppRouter>();

  ProfilePresentation _presentation = const ProfilePresentation();

  ProfilePresentation get presentation => _presentation;

  void init() {
    try {
      _presentation = presentation.copyWith(isLoading: true);
      notifyListeners();

      final userLogin = _prefsService.getUserLogin();

      _presentation = presentation.copyWith(user: userLogin);
    } catch (error) {
      showInformationDialog(error);
    } finally {
      _presentation = presentation.copyWith(isLoading: false);
      notifyListeners();
    }
  }

  Future<void> logout() async {
    try {
      await _prefsService.clearAllData();
      return await _appRouter.rootClearAndNavigateTo(Routes.splash);
    } catch (error) {
      showInformationDialog(error);
    }
  }
}
