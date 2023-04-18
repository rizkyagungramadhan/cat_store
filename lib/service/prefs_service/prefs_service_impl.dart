import 'dart:convert';

import 'package:cat_store/api/product/model/product_response.dart';
import 'package:cat_store/api/user/model/user_response.dart';
import 'package:cat_store/common/exception/app_exception.dart';
import 'package:cat_store/common/model/collection_stub.dart';
import 'package:cat_store/service/prefs_service/prefs_collection.dart';
import 'package:cat_store/service/prefs_service/prefs_service.dart';
import 'package:cat_store/utility/extension/string_ext.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsServiceImpl implements PrefsService {
  late SharedPreferences _prefs;

  @override
  Future<void> initialize() async {
    try {
      _prefs = await SharedPreferences.getInstance();
    } catch (e) {
      throw AppException('Error when try to initiate SharedPreferences');
    }
  }

  @override
  Future<bool> saveUserLogin(UserResponse userResponse) async {
    return await _prefs.setString(
      PrefsCollection.userLogin.key,
      jsonEncode(userResponse.toJson()),
    );
  }

  @override
  UserResponse? getUserLogin() {
    final userPrefs = _prefs.getString(PrefsCollection.userLogin.key);
    if (userPrefs != null) {
      return UserResponse.fromJson(jsonDecode(userPrefs));
    }

    return null;
  }

  @override
  Future<void> clearAllData() async {
    final operations = await Future.wait(
      PrefsCollection.values.map(
        (obj) async => await _prefs.remove(obj.key),
      ),
    );

    if (operations.contains(false)) {
      throw AppException('Failed to clear Preference data');
    }
  }

  @override
  Future<bool> addProductToCart(ProductResponse productResponse) async {
    final currentCart = await getProductsFromCart();

    var cartData = <ProductResponse>[];
    cartData.addAll(currentCart.data);
    cartData.insert(0, productResponse);

    return await _prefs.setString(
      PrefsCollection.cart.key,
      jsonEncode(
        CollectionStub(data: cartData).toJson(
          (value) => value.toJson(),
        ),
      ),
    );
  }

  @override
  Future<CollectionStub<ProductResponse>> getProductsFromCart() async {
    final cart = _prefs.getString(PrefsCollection.cart.key);
    if (cart.isNullOrEmpty) return const CollectionStub(data: []);

    final mapValue = jsonDecode(cart!);
    final result = CollectionStub.fromJson(
      mapValue,
      (json) => ProductResponse.fromJson(json),
    );
    return result;
  }
}
