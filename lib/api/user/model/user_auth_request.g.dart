// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_auth_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAuthRequest _$UserAuthRequestFromJson(Map<String, dynamic> json) =>
    UserAuthRequest(
      username: json['username'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$UserAuthRequestToJson(UserAuthRequest instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
    };
