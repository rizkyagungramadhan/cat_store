// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_credential_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserCredentialResponse _$UserCredentialResponseFromJson(
        Map<String, dynamic> json) =>
    UserCredentialResponse(
      json['id'] as int,
      json['username'] as String,
      json['password'] as String,
    );

Map<String, dynamic> _$UserCredentialResponseToJson(
        UserCredentialResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'password': instance.password,
    };
