// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductResponse _$ProductResponseFromJson(Map<String, dynamic> json) =>
    ProductResponse(
      json['id'] as int,
      json['title'] as String,
      json['description'] as String,
      json['price'] as num,
      (json['rating'] as num).toDouble(),
      json['stock'] as int,
      json['brand'] as String,
      json['thumbnail'] as String,
      json['category'] as String,
      (json['images'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ProductResponseToJson(ProductResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'price': instance.price,
      'rating': instance.rating,
      'stock': instance.stock,
      'brand': instance.brand,
      'thumbnail': instance.thumbnail,
      'category': instance.category,
      'images': instance.images,
    };
