import 'package:dio/dio.dart';

abstract class DioClient {
  /// Doc : Use it for [GET] method.
  /// Use [options] if you want to override [BaseOptions]
  /// provided inside [initialize] on factory
  Future<Response<dynamic>> get(
    String uriPath, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  });

  /// Doc : Use it for [POST] method.
  /// Use [options] if you want to override [BaseOptions]
  /// provided inside [initialize] on factory
  Future<Response<dynamic>> post(
    String uriPath, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  });
}
