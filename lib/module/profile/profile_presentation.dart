import 'package:cat_store/api/product/model/product_response.dart';
import 'package:cat_store/api/user/model/user_response.dart';
import 'package:equatable/equatable.dart';

class ProfilePresentation extends Equatable {
  final UserResponse? user;
  final bool isLoading;
  final List<ProductCartItem> cartItems;

  const ProfilePresentation({
    this.user,
    this.isLoading = false,
    this.cartItems = const [],
  });

  ProfilePresentation copyWith({
    UserResponse? user,
    bool? isLoading,
    List<ProductCartItem>? cartItems,
  }) {
    return ProfilePresentation(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      cartItems: cartItems ?? this.cartItems,
    );
  }

  @override
  List<Object?> get props => [user, isLoading, cartItems];
}

class ProductCartItem extends ProductResponse {
  final int total;

  ProductCartItem(
    super.id,
    super.title,
    super.description,
    super.price,
    super.rating,
    super.stock,
    super.brand,
    super.thumbnail,
    super.category,
    super.images,
    this.total,
  );

  factory ProductCartItem.fromResponse({
    required ProductResponse obj,
    required int total,
  }) {
    return ProductCartItem(
      obj.id,
      obj.title,
      obj.description,
      obj.price,
      obj.rating,
      obj.stock,
      obj.brand,
      obj.thumbnail,
      obj.category,
      obj.images,
      total,
    );
  }
}
