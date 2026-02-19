abstract class WishListEvent {
  @override
  List<Object> get props => [];
}

class GetAllWishListIds extends WishListEvent {}

class AddToWishList extends WishListEvent {
  AddToWishList(
      {required this.banner_image,
      required this.title,
      required this.price,
      required this.productId});

  String banner_image;
  String title;
  int price;
  String productId;

  List<Object> get props => [banner_image, title, price, productId];
}

class GetSingleWishListEvent extends WishListEvent {
  GetSingleWishListEvent({required this.product_id});
  String product_id;

  List<Object> get props => [product_id];
}

class ProductWishListExitst extends WishListEvent {
  ProductWishListExitst({required this.product_id, required this.qtyType});
  String product_id;
  String qtyType;
  List<Object> get props => [product_id, qtyType];
}

class ClearProductDetail extends WishListEvent {}
