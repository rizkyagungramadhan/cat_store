import 'package:json_annotation/json_annotation.dart';

part 'collection_stub.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class CollectionStub<T> {
  final List<T> data;

  const CollectionStub({required this.data});

  factory CollectionStub.fromList(List<T> values) => CollectionStub(
        data: values,
      );

  factory CollectionStub.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$CollectionStubFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$CollectionStubToJson(this, toJsonT);
}
