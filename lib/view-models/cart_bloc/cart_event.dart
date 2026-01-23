abstract class CartEvent {
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
