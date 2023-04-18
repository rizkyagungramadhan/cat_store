import 'package:cat_store/api/product/model/product_response.dart';
import 'package:cat_store/api/response_list.dart';

abstract class ProductRepository {
  Future<ResponseList<ProductResponse>> getProducts({
    int limit = 10,
    int skip = 0,
  });

  Future<ProductResponse?> getFeaturedProduct(int productId);

  Future<ResponseList<ProductResponse>> getProductsByCategory(String category);
}
