import 'package:cat_store/api/product/model/product_response.dart';
import 'package:cat_store/module/product/detail/product_detail_presentation.dart';
import 'package:cat_store/utility/extension/string_ext.dart';
import 'package:cat_store/utility/view_model_mixin.dart';
import 'package:flutter/material.dart';

class ProductDetailViewModel extends ChangeNotifier with ViewModelMixin {
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
      final images =presentation.images;
      if(images.isEmpty) return;

      const firstPageIndex = 0;
      final lastPageIndex = presentation.images.length -1;
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
}
