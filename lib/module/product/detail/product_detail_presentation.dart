import 'package:equatable/equatable.dart';

class ProductDetailPresentation extends Equatable {
  final String selectedImage;
  final List<String> images;

  const ProductDetailPresentation({
    this.selectedImage = '',
    this.images = const [],
  });

  ProductDetailPresentation copyWith({
    String? selectedImage,
    List<String>? images,
  }) {
    return ProductDetailPresentation(
      selectedImage: selectedImage ?? this.selectedImage,
      images: images ?? this.images,
    );
  }

  @override
  List<Object> get props => [selectedImage];
}
