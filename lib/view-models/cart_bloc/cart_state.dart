import 'package:ecom_app/models/cart_item_model/cart_item_model.dart';

abstract class CartState {
  @override
  List<Object> get props => [];
}

class CartStateInitial extends CartState {}

class CartStateLoading extends CartState {}

class CartProductError extends CartState {
  CartProductError(this.error);
  String error;
}

class CartStateSuccess extends CartState {
  CartStateSuccess();
}

class CartLoaded extends CartState{
  List cartItems;
  CartLoaded({required this.cartItems});
  @override
  List<Object> get props => [cartItems];
}
