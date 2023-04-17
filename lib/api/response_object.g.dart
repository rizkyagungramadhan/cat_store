// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_object.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseObject<T> _$ResponseObjectFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    ResponseObject<T>(
      data: _$nullableGenericFromJson(json['data'], fromJsonT),
      status: json['status'] as int?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ResponseObjectToJson<T>(
  ResponseObject<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'data': _$nullableGenericToJson(instance.data, toJsonT),
      'status': instance.status,
      'message': instance.message,
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);
