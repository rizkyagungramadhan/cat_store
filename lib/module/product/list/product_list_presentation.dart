import 'package:equatable/equatable.dart';

class ProductListPresentation extends Equatable {
  final bool isLoading;

  const ProductListPresentation({this.isLoading = false});

  ProductListPresentation copyWith({bool? isLoading}) {
    return ProductListPresentation(isLoading: isLoading ?? this.isLoading);
  }

  @override
  List<Object> get props => [isLoading];
}
