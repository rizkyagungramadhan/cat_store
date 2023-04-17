import 'package:cat_store/api/product/model/product_response.dart';
import 'package:equatable/equatable.dart';

class ProductListPresentation extends Equatable {
  final bool isLoading;
  final ProductResponse? featuredProduct;
  final int carouselPosition;
  final bool isAppBarPinned;

  const ProductListPresentation({
    this.isLoading = false,
    this.featuredProduct,
    this.carouselPosition = 0,
    this.isAppBarPinned = false,
  });

  ProductListPresentation copyWith({
    bool? isLoading,
    ProductResponse? featuredProduct,
    int? carouselPosition,
    bool? isAppBarPinned,
  }) {
    return ProductListPresentation(
      isLoading: isLoading ?? this.isLoading,
      featuredProduct: featuredProduct ?? this.featuredProduct,
      carouselPosition: carouselPosition ?? this.carouselPosition,
      isAppBarPinned: isAppBarPinned ?? this.isAppBarPinned,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        featuredProduct,
        carouselPosition,
        isAppBarPinned,
      ];
}
