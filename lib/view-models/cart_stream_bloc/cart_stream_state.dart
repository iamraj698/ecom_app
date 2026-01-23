import 'package:ecom_app/models/cart_item_model/cart_item_model.dart';
import 'package:equatable/equatable.dart';

abstract class CartStreamState extends Equatable {
  @override
  List<Object> get props => [];
}

class CartStreamStateInitial extends CartStreamState {}

class CartStreamStateLoading extends CartStreamState {}

class CartStreamError extends CartStreamState {
  CartStreamError(this.error);
  String error;
}

class CartStreamLoaded extends CartStreamState {
  List<CartItemModel> cartItems;
  CartStreamLoaded({required this.cartItems});
  @override
  List<Object> get props => [cartItems];
}
