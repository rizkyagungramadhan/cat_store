import 'package:cat_store/api/client/dio_client.dart';
import 'package:cat_store/api/product/model/product_response.dart';
import 'package:cat_store/api/product/product_repository.dart';
import 'package:cat_store/api/response_list.dart';
import 'package:cat_store/di/service_locator.dart';
import 'package:dio/dio.dart';

class ProductRepositoryImpl implements ProductRepository {
  final _dioClient = serviceLocator<DioClient>();

  @override
  Future<ResponseList<ProductResponse>> getProducts({
    int limit = 10,
    int skip = 0,
  }) async {
    return await _dioClient.get('/products?limit=$limit&skip=$skip').then(
          (Response response) => ResponseList.fromJson(
            response.data,
            (json) => ProductResponse.fromJson(
              json as Map<String, dynamic>,
            ),
            'products',
          ),
        );
  }

  @override
  Future<ProductResponse?> getFeaturedProduct(int productId) async {
    return await _dioClient.get('/products/$productId').then(
          (Response response) => ProductResponse.fromJson(
            response.data as Map<String, dynamic>,
          ),
        );
  }
}
