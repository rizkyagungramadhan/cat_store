import 'package:cat_store/api/product/model/product_response.dart';
import 'package:equatable/equatable.dart';

class ProductDetailPresentation extends Equatable {
  final String selectedImage;
  final List<String> images;
  final List<ProductResponse> similarProducts;
  final bool isLoading;

  const ProductDetailPresentation({
    this.selectedImage = '',
    this.images = const [],
    this.similarProducts = const [],
    this.isLoading = false,
  });

  ProductDetailPresentation copyWith({
    String? selectedImage,
    List<String>? images,
    List<ProductResponse>? similarProducts,
    bool? isLoading,
  }) {
    return ProductDetailPresentation(
      selectedImage: selectedImage ?? this.selectedImage,
      images: images ?? this.images,
      similarProducts: similarProducts ?? this.similarProducts,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object> get props => [
        selectedImage,
        images,
        similarProducts,
        isLoading,
      ];
}
