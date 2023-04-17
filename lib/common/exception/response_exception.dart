import 'package:cat_store/common/exception/app_exception.dart';

class ResponseException implements AppException {
  @override
  String message;

  ResponseException(this.message);

  @override
  String toString() => message;
}
