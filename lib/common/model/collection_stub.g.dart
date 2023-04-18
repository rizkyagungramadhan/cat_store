// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_stub.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CollectionStub<T> _$CollectionStubFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    CollectionStub<T>(
      data: (json['data'] as List<dynamic>).map(fromJsonT).toList(),
    );

Map<String, dynamic> _$CollectionStubToJson<T>(
  CollectionStub<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'data': instance.data.map(toJsonT).toList(),
    };
