import 'package:ecom_app/models/product_model/product_model.dart';
import 'package:ecom_app/models/wishlist_product_model/wishlist_product_model.dart';

class WishListState {
  final bool isLoading;
  // final ProductModel? product;
  List<WishListModel> product;
  final bool isInCart;
  final bool isWishListing;
  final bool cartFetched;

  final String? error;

  WishListState({
    this.isLoading = false,
    this.product = const [],
    this.isInCart = false,
    this.error,
    this.isWishListing = false,
    this.cartFetched = false,
  });

  WishListState copyWith(
      {bool? isLoading,
      // ProductModel? product,
      List<WishListModel>? product,
      bool? isInCart,
      String? error,
      bool? isWishListing,
      bool? cartFetched}) {
    return WishListState(
      isLoading: isLoading ?? this.isLoading,
      product: product ?? this.product,
      isInCart: isInCart ?? this.isInCart,
      error: error,
      isWishListing: isWishListing ?? this.isWishListing,
      cartFetched: cartFetched ?? this.cartFetched,
    );
  }
}
