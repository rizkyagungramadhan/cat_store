import 'package:cat_store/api/product/model/product_response.dart';
import 'package:cat_store/api/user/model/user_response.dart';
import 'package:cat_store/common/model/collection_stub.dart';

abstract class PrefsService {


  /// Initialize

  Future<void> initialize();

  Future<bool> saveUserLogin(UserResponse userResponse);

  UserResponse? getUserLogin();

  Future<bool> addProductToCart(ProductResponse productResponse);

  Future<CollectionStub<ProductResponse>> getProductsFromCart();

  Future<void> clearAllData();

}