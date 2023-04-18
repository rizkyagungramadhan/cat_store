import 'dart:async';

import 'package:cat_store/api/product/model/product_response.dart';
import 'package:cat_store/api/product/product_repository.dart';
import 'package:cat_store/common/exception/app_exception.dart';
import 'package:cat_store/di/service_locator.dart';
import 'package:cat_store/module/product/detail/product_detail_presentation.dart';
import 'package:cat_store/service/prefs_service/prefs_service.dart';
import 'package:cat_store/utility/route/app_route.dart';
import 'package:cat_store/utility/route/app_router.dart';
import 'package:cat_store/utility/view_model_mixin.dart';
import 'package:flutter/material.dart';

class ProductDetailViewModel extends ChangeNotifier with ViewModelMixin {
  final _productRepository = serviceLocator<ProductRepository>();
  final _prefsService = serviceLocator<PrefsService>();
  ProductDetailPresentation _presentation = const ProductDetailPresentation();

  ProductDetailPresentation get presentation => _presentation;
  final controller = PageController();

  void init(ProductResponse product) {
    try {
      final images = product.images.reversed.toList();
      _presentation = presentation.copyWith(
        selectedImage: images.first,
        images: images,
      );

      notifyListeners();
    } catch (error) {
      logError(error);
    }
  }

  Future<void> swipeImage(DragUpdateDetails data) async {
    try {
      final images = presentation.images;
      if (images.isEmpty) return;

      const firstPageIndex = 0;
      final lastPageIndex = presentation.images.length - 1;
      final xOffset = data.delta.dx;

      // Handle right swipe
      if (xOffset > 0) {
        if (controller.page == firstPageIndex) return;
        await controller.previousPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOutCubic,
        );
      }

      // Handle left swipe
      if (xOffset < 0) {
        if (controller.page == lastPageIndex) return;
        await controller.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOutCubic,
        );
      }
    } catch (error) {
      logError(error);
    }
  }

  Future<void> onPageChanged(int pagePosition) async {
    try {
      await controller.animateToPage(
        pagePosition,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } catch (error) {
      logError(error);
    }
  }

  Future<void> getSimilarProducts(
    String category,
    int currentProductId,
  ) async {
    try {
      final similarProducts =
          await _productRepository.getProductsByCategory(category);

      if (similarProducts.data?.isNotEmpty ?? false) {
        similarProducts.data?.removeWhere((p) => p.id == currentProductId);
        similarProducts.data?.shuffle();
        _presentation = presentation.copyWith(
          similarProducts: similarProducts.data,
        );
        notifyListeners();
      }
    } catch (error) {
      logError(error);
    }
  }

  Future<void> openSimilarProductDetail(ProductResponse item) async {
    try {
      unawaited(
        serviceLocator<AppRouter>().rootNavigateTo(Routes.productDetail, item),
      );
    } catch (error) {
      showInformationDialog(error);
    }
  }

  Future<void> addToCart(ProductResponse productResponse) async {
    try {
      _presentation = presentation.copyWith(isLoading: true);
      notifyListeners();
      final isSaved = await _prefsService.addProductToCart(productResponse);

      if (isSaved) {
        showInformationDialog(
          'Successfully add ${productResponse.title} to your cart',
        );
      } else {
        throw AppException('Failed to add this product to your cart');
      }
    } catch (error) {
      showInformationDialog(error);
    } finally {
      _presentation = presentation.copyWith(isLoading: false);
      notifyListeners();
    }
  }
}
