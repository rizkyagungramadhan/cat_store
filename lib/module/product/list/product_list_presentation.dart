import 'package:cat_store/api/product/model/product_response.dart';
import 'package:equatable/equatable.dart';

class ProductListPresentation extends Equatable {
  final bool isLoading;
  final ProductResponse? featuredProduct;
  final int carouselPosition;
  final bool isAppBarPinned;
  final bool isItemNotEmpty;
  final ItemViewType itemViewType;

  const ProductListPresentation({
    this.isLoading = false,
    this.featuredProduct,
    this.carouselPosition = 0,
    this.isAppBarPinned = false,
    this.isItemNotEmpty = false,
    this.itemViewType = ItemViewType.grid,
  });

  ProductListPresentation copyWith({
    bool? isLoading,
    ProductResponse? featuredProduct,
    int? carouselPosition,
    bool? isAppBarPinned,
    bool? isItemNotEmpty,
    ItemViewType? itemViewType,
  }) {
    return ProductListPresentation(
      isLoading: isLoading ?? this.isLoading,
      featuredProduct: featuredProduct ?? this.featuredProduct,
      carouselPosition: carouselPosition ?? this.carouselPosition,
      isAppBarPinned: isAppBarPinned ?? this.isAppBarPinned,
      isItemNotEmpty: isItemNotEmpty ?? this.isItemNotEmpty,
      itemViewType: itemViewType ?? this.itemViewType,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        featuredProduct,
        carouselPosition,
        isAppBarPinned,
        isItemNotEmpty,
        itemViewType,
      ];
}

enum ItemViewType {
  grid,
  list;
}
