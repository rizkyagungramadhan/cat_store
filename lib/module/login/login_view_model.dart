import 'package:cat_store/api/user/model/user_auth_request.dart';
import 'package:cat_store/api/user/model/user_response.dart';
import 'package:cat_store/api/user/user_repository.dart';
import 'package:cat_store/common/exception/app_exception.dart';
import 'package:cat_store/di/service_locator.dart';
import 'package:cat_store/module/login/login_presentation.dart';
import 'package:cat_store/module/login/widgets/user_list_dialog.dart';
import 'package:cat_store/service/prefs_service/prefs_service.dart';
import 'package:cat_store/utility/route/app_route.dart';
import 'package:cat_store/utility/route/app_router.dart';
import 'package:cat_store/utility/view_model_mixin.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginViewModel extends ChangeNotifier with ViewModelMixin {
  final txUserName = TextEditingController();
  final txPassword = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();

  final _appRouter = serviceLocator<AppRouter>();
  final _userRepository = serviceLocator<UserRepository>();
  final _prefsService = serviceLocator<PrefsService>();
  LoginPresentation _presentation = const LoginPresentation();

  LoginPresentation get presentation => _presentation;

  void togglePasswordVisibility() {
    _presentation = presentation.copyWith(
      isPasswordVisible: !presentation.isPasswordVisible,
    );
    notifyListeners();
  }

  Future<void> login() async {
    try {
      if (loginFormKey.currentState?.validate() ?? false) {
        _presentation = presentation.copyWith(isLoading: true);
        notifyListeners();

        final request = UserAuthRequest(
          username: txUserName.text,
          password: txPassword.text,
        );

        final response = await _userRepository.login(request);
        if (response is UserResponse) {
          final isSaved = await _prefsService.saveUserLogin(response);
          if (!isSaved) throw AppException('Failed to save user data');
          return _appRouter.rootClearAndNavigateTo(Routes.home);
        }
      }
    } catch (error) {
      showInformationDialog(error);
    } finally {
      _presentation = presentation.copyWith(isLoading: false);
      notifyListeners();
    }
  }

  Future<void> seeAllUserOnWeb() async {
    try {
      final isCanLaunchUrl = await launchUrl(
        Uri.parse('https://dummyjson.com/users?select=username,password'),
      );

      if (!isCanLaunchUrl) {
        throw AppException('Could not show all user data');
      }
    } catch (error) {
      showInformationDialog(error);
    }
  }

  Future<void> showAllRegisteredUsers() async {
    try {
      _presentation = presentation.copyWith(isLoadingRegisteredUsers: true);
      notifyListeners();

      final registeredUsers = await _userRepository.getAllRegisteredUser();

      if (registeredUsers.data?.isEmpty ?? true) {
        throw AppException('Cannot fetch registered users data');
      }

      showPopUpDialog(
        child: UserListDialog(
          registeredUsers: registeredUsers.data ?? [],
          onUserSelected: (user) {
            txUserName.text = user.username;
            txPassword.text = user.password;
          },
        ),
      );
    } catch (error) {
      showInformationDialog(error);
    } finally {
      _presentation = presentation.copyWith(isLoadingRegisteredUsers: false);
      notifyListeners();
    }
  }

  @override
  void dispose() {
    txUserName.dispose();
    txPassword.dispose();
    super.dispose();
  }
}
