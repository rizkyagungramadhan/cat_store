import 'package:cat_store/api/client/dio_client.dart';
import 'package:cat_store/api/response_list.dart';
import 'package:cat_store/api/response_object.dart';
import 'package:cat_store/api/user/model/user_auth_request.dart';
import 'package:cat_store/api/user/model/user_credential_response.dart';
import 'package:cat_store/api/user/model/user_response.dart';
import 'package:cat_store/api/user/user_repository.dart';
import 'package:cat_store/di/service_locator.dart';
import 'package:dio/dio.dart';

class UserRepositoryImpl implements UserRepository {
  final _dioClient = serviceLocator<DioClient>();

  @override
  Future<ResponseList<UserCredentialResponse>> getAllRegisteredUser() async {
    return await _dioClient.get('/users?select=username,password').then(
          (Response response) => ResponseList.fromJson(
            response.data,
            (json) => UserCredentialResponse.fromJson(
              json as Map<String, dynamic>,
            ),
            'users',
          ),
        );
  }

  @override
  Future<UserResponse?> login(UserAuthRequest request) async {
    final cek = await _dioClient.post('/auth/login', data: request.toJson());
    cek.toString();
    return await _dioClient.post('/auth/login', data: request.toJson()).then(
          (Response response) => UserResponse.fromJson(
            response.data as Map<String, dynamic>,
          ),
        );
  }
}
