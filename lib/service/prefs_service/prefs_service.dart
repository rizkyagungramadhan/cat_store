import 'package:cat_store/api/user/model/user_response.dart';

abstract class PrefsService {


  /// Initialize

  Future<void> initialize();

  Future<bool> saveUserLogin(UserResponse userResponse);

  UserResponse? getUserLogin();

  Future<void> clearAllData();
}