import 'dart:async';

import 'package:cat_store/api/product/model/product_response.dart';
import 'package:cat_store/di/service_locator.dart';
import 'package:cat_store/module/profile/profile_presentation.dart';
import 'package:cat_store/service/prefs_service/prefs_service.dart';
import 'package:cat_store/utility/route/app_route.dart';
import 'package:cat_store/utility/route/app_router.dart';
import 'package:cat_store/utility/view_model_mixin.dart';
import 'package:flutter/material.dart';

class ProfileViewModel extends ChangeNotifier with ViewModelMixin {
  final _prefsService = serviceLocator<PrefsService>();
  final _appRouter = serviceLocator<AppRouter>();

  ProfilePresentation _presentation = const ProfilePresentation();

  ProfilePresentation get presentation => _presentation;

  void init() {
    try {
      _presentation = presentation.copyWith(isLoading: true);
      notifyListeners();
      unawaited(_getCartItems());

      final userLogin = _prefsService.getUserLogin();

      _presentation = presentation.copyWith(user: userLogin);
    } catch (error) {
      showInformationDialog(error);
    } finally {
      _presentation = presentation.copyWith(isLoading: false);
      notifyListeners();
    }
  }

  Future<void> logout() async {
    try {
      await _prefsService.clearAllData();
      return await _appRouter.rootClearAndNavigateTo(Routes.splash);
    } catch (error) {
      showInformationDialog(error);
    }
  }

  Future<void> _getCartItems() async {
    try {
      final cartItems = await _prefsService.getProductsFromCart();

      final items = _groupProduct(cartItems.data);
      _presentation = presentation.copyWith(
        cartItems: items,
      );
      notifyListeners();
    } catch (error) {
      logError(error);
    }
  }

  List<ProductCartItem> _groupProduct(List<ProductResponse> products) {
    try {
      var countProductMap = <int, int>{};
      for (var product in products) {
        countProductMap[product.id] = (countProductMap[product.id] ?? 0) + 1;
      }

      var cartItems = <ProductCartItem>[];
      for (var product in products) {
        var total = countProductMap[product.id];
        if (total != null) {
          cartItems.add(
            ProductCartItem.fromResponse(obj: product, total: total),
          );
          countProductMap.remove(product.id);
        }
      }

      return cartItems;
    } catch (error) {
      logError(error);
      return [];
    }
  }

  Future<void> openDetailProduct(ProductResponse item) async {
    try {
      unawaited(
        _appRouter.rootNavigateTo(Routes.productDetail, item),
      );
    } catch (error) {
      logError(error);
    }
  }
}
