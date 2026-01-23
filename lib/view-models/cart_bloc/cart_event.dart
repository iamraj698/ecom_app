import 'package:equatable/equatable.dart';

abstract class CartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddCartProduct extends CartEvent {
  AddCartProduct({
    required this.productId,
    required this.title,
    required this.priceAtTime,
    required this.createdAt,
    required this.quantity,
    required this.qtyType,
    required this.banner_image,
  });
  String productId;
  String title;
  int priceAtTime;
  String createdAt;
  String banner_image;
  String qtyType;
  int quantity;
}

// class FetchCartItems extends CartEvent {
//   FetchCartItems();
// }

class DeleteCartItem extends CartEvent {
  DeleteCartItem({required this.cartProdId});

  String cartProdId;

  @override
  List<Object> get props => [cartProdId];
}

class IncrementCartItem extends CartEvent {
  IncrementCartItem({required this.cartProdId});

  String cartProdId;

  @override
  List<Object> get props => [cartProdId];
}

class DecrementCartItem extends CartEvent {
  DecrementCartItem({required this.cartProdId});
  String cartProdId;
  @override
  List<Object> get props => [cartProdId];
}
