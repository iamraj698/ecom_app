// import 'package:ecom_app/models/product_model/product_model.dart';

// abstract class ProductDetailState {
//   @override
//   List<Object> get props => [];
// }

// class ProductDetailStateInitial extends ProductDetailState {}

// class ProductDetailStateLoading extends ProductDetailState {}

// class ProductDetailFetchErrorState extends ProductDetailState {
//   ProductDetailFetchErrorState(this.error);
//   String error;
// }

// class SingleProductLoaded extends ProductDetailState {
//   SingleProductLoaded(this.product);
//   ProductModel product;
//   List<Object> get props => [product];
// }

// class ProductCartExist extends ProductDetailState {
//   ProductCartExist();
// }

// class ProductCartIsNotExist extends ProductDetailState {
//   ProductCartIsNotExist();
// }

import 'package:ecom_app/models/product_model/product_model.dart';

class ProductDetailState {
  final bool isLoading;
  final ProductModel? product;
  final bool isInCart;
  final bool hasFetched;
  final bool cartFetched;

  final String? error;

  ProductDetailState({
    this.isLoading = false,
    this.product,
    this.isInCart = false,
    this.error,
    this.hasFetched = false,
    this.cartFetched = false,
  });

  ProductDetailState copyWith(
      {bool? isLoading,
      ProductModel? product,
      bool? isInCart,
      String? error,
      bool? hasFetched,
      bool? cartFetched}) {
    return ProductDetailState(
      isLoading: isLoading ?? this.isLoading,
      product: product ?? this.product,
      isInCart: isInCart ?? this.isInCart,
      error: error,
      hasFetched: hasFetched ?? this.hasFetched,
      cartFetched: cartFetched ?? this.cartFetched,
    );
  }
}
