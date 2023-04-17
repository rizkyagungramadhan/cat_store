import 'package:cat_store/api/response_list.dart';
import 'package:cat_store/api/user/model/user_auth_request.dart';
import 'package:cat_store/api/user/model/user_credential_response.dart';
import 'package:cat_store/api/user/model/user_response.dart';

abstract class UserRepository {
  Future<ResponseList<UserCredentialResponse>> getAllRegisteredUser();

  Future<UserResponse?> login(UserAuthRequest request);
}
