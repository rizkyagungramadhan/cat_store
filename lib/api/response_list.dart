import 'package:cat_store/common/exception/app_exception.dart';
import 'package:cat_store/common/exception/response_exception.dart';
import 'package:cat_store/utility/extension/string_ext.dart';
import 'package:json_annotation/json_annotation.dart';

part 'response_list.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ResponseList<T> {
  final int? total;
  final List<T>? data;
  final String? status;
  final String? message;

  const ResponseList({
    this.total = 0,
    required this.data,
    this.status,
    this.message,
  });

  /// Doc : [response] should be [Map<String, dynamic>]
  /// for cast to be successful.
  factory ResponseList.fromJson(
      dynamic response, T Function(Object? json) fromJsonT,
      [String? customFieldName]) {
    if (response is! Map<String, dynamic>) {
      throw AppException('Response should be in Map types');
    }

    /// Handle JSON key from current API which return different key name
    if (!response.containsKey('data')) {
      if (customFieldName is String) {
        if (response.containsKey(customFieldName)) {
          final responseData = response[customFieldName];
          response.addAll({'data': responseData});
        }
      }
    }

    return _$ResponseListFromJson(response, fromJsonT);
  }

  /// Doc : Validate Response. Will throw [ResponseException]
  /// with [errorMessage] inside it when failed.
  void validate() {
    if ((data ?? []).isNotEmpty && errorMessage.isNotNullOrEmpty) return;
    throw ResponseException(errorMessage);
  }

  String get errorMessage =>
      (data is String ? data as String : message) ??
      (status is int
          ? 'Oops something went wrong with error code : $status'
          : 'Unknown error');
}
