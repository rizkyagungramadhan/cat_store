import 'package:cat_store/api/product/model/product_response.dart';
import 'package:cat_store/api/product/product_repository.dart';
import 'package:cat_store/di/service_locator.dart';
import 'package:cat_store/module/product/list/product_list_presentation.dart';
import 'package:cat_store/utility/view_model_mixin.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ProductListViewModel extends ChangeNotifier with ViewModelMixin {
  final _pageSize = 10;
  final pagingController =
      PagingController<int, ProductResponse>(firstPageKey: 0);
  final _productRepository = serviceLocator<ProductRepository>();

  ProductListPresentation _presentation = const ProductListPresentation();

  ProductListPresentation get presentation => _presentation;

  void init() {
    pagingController.addPageRequestListener((pageKey) {
      getProducts(pageKey);
    });
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
      _presentation = presentation.copyWith(isLoading: false);
      notifyListeners();
    }
  }
}
