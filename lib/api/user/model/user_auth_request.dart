import 'package:cat_store/api/i_request.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_auth_request.g.dart';

@JsonSerializable()
class UserAuthRequest implements IRequest {
  final String username;
  final String password;

  UserAuthRequest({required this.username, required this.password});

  @override
  Map<String, dynamic> toJson() => _$UserAuthRequestToJson(this);
}
