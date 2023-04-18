import 'package:cat_store/common/exception/app_exception.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_response.g.dart';

@JsonSerializable()
class ProductResponse {
  final int id;
  final String title;
  final String description;
  final num price;
  final double rating;
  final int stock;
  final String brand;
  final String thumbnail;
  final String category;
  final List<String> images;

  ProductResponse(
    this.id,
    this.title,
    this.description,
    this.price,
    this.rating,
    this.stock,
    this.brand,
    this.thumbnail,
    this.category,
    this.images,
  );

  factory ProductResponse.fromJson(dynamic json) {
    if (json is! Map<String, dynamic>) {
      throw AppException('ProductResponse should be in Map types');
    }
    return _$ProductResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ProductResponseToJson(this);
}
