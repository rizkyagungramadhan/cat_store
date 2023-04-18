import 'dart:async';

import 'package:cat_store/api/product/model/product_response.dart';
import 'package:cat_store/api/product/product_repository.dart';
import 'package:cat_store/di/service_locator.dart';
import 'package:cat_store/module/product/list/product_list_presentation.dart';
import 'package:cat_store/utility/route/app_route.dart';
import 'package:cat_store/utility/route/app_router.dart';
import 'package:cat_store/utility/view_model_mixin.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ProductListViewModel extends ChangeNotifier with ViewModelMixin {
  final _pageSize = 10;
  final pagingController =
      PagingController<int, ProductResponse>(firstPageKey: 0);
  final _productRepository = serviceLocator<ProductRepository>();

  ProductListPresentation _presentation = const ProductListPresentation();
  final ScrollController scrollController = ScrollController();

  ProductListPresentation get presentation => _presentation;

  void init() async {
    pagingController.addPageRequestListener((pageKey) {
      getProducts(pageKey);
    });

    scrollController.addListener(() {
      if (!presentation.isAppBarPinned &&
          scrollController.hasClients &&
          scrollController.offset > (kToolbarHeight - 4)) {
        _presentation = presentation.copyWith(isAppBarPinned: true);
        notifyListeners();
      } else if (presentation.isAppBarPinned &&
          scrollController.hasClients &&
          scrollController.offset < (kToolbarHeight - 4)) {
        _presentation = presentation.copyWith(isAppBarPinned: false);
        notifyListeners();
      }
    });
  }

  void refresh() {
    pagingController.refresh();
    _presentation = presentation.copyWith(isItemNotEmpty: false);
    notifyListeners();
  }

  Future<void> getProducts(int pageKey) async {
    try {
      _presentation = presentation.copyWith(isLoading: true);
      notifyListeners();

      final productList = await _productRepository.getProducts(
        limit: _pageSize,
        skip: pageKey,
      );

      final productListData = productList.data ?? [];
      final isLastPage = productListData.length < _pageSize;

      if (isLastPage) {
        pagingController.appendLastPage(productListData);
      } else {
        final nextPageKey = pageKey + productListData.length;
        pagingController.appendPage(productListData, nextPageKey);
      }
    } catch (error) {
      showInformationDialog(error);
    } finally {
      _presentation = presentation.copyWith(
        isLoading: false,
        isItemNotEmpty: pagingController.value.itemList?.isNotEmpty ?? false,
      );
      notifyListeners();
    }
  }

  Future<void> openDetailProduct(ProductResponse product) async {
    try {
      unawaited(
        serviceLocator<AppRouter>().rootNavigateTo(
          Routes.productDetail,
          product,
        ),
      );
    } catch (error) {
      logError(error);
    }
  }

  Future<void> getFeaturedProduct() async {
    try {
      final featuredProduct = await _productRepository.getFeaturedProduct(9);
      if (featuredProduct is ProductResponse) {
        _presentation = presentation.copyWith(featuredProduct: featuredProduct);
        notifyListeners();
      }
    } catch (error) {
      logError(error);
    }
  }

  void changeCarouselPosition(int index) {
    try {
      if (presentation.featuredProduct?.images.isEmpty ?? true) return;
      _presentation = presentation.copyWith(carouselPosition: index);
      notifyListeners();
    } catch (error) {
      logError(error);
    }
  }

  void switchItemView(ItemViewType itemViewType) {
    _presentation = presentation.copyWith(itemViewType: itemViewType);
    notifyListeners();
  }

// @override
// void dispose() {
//   pagingController.dispose();
//   super.dispose();
// }
}
