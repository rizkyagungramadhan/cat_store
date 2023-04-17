import 'package:cat_store/common/exception/app_exception.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_credential_response.g.dart';

@JsonSerializable()
class UserCredentialResponse {
  final int id;
  final String username;
  final String password;

  UserCredentialResponse(this.id, this.username, this.password);

  factory UserCredentialResponse.fromJson(dynamic json) {
    if (json is! Map<String, dynamic>) {
      throw AppException('UserCredentialResponse should be in Map types');
    }
    return _$UserCredentialResponseFromJson(json);
  }
}
