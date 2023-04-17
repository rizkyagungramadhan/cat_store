import 'package:cat_store/common/exception/response_exception.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_object.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ResponseObject<T> {
  T? data;
  int? status;
  String? message;

  ResponseObject({this.data, this.status, this.message});

  factory ResponseObject.fromJson(
    dynamic response,
    T Function(Object? json) fromJsonT,
  ) {
    return _$ResponseObjectFromJson(response, fromJsonT);
  }

  /// Doc : Validate status code from Response. Will throw [ResponseException]
  /// with [message] inside it when failed.
  void validate() {
    if ((status ?? 0) < 400) return;
    throw ResponseException(message ?? 'Oops something went wrong');
  }
}
