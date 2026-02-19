import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_app/data/repositories/product_repository.dart';
import 'package:ecom_app/models/wishlist_product_model/wishlist_product_model.dart';
import 'package:ecom_app/view-models/wish_list_bloc/wishlist.dart';

// import 'package:ecom_app/view-models/products_bloc/get_products.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class WishListBloc extends Bloc<WishListEvent, WishListState> {
  final _productRepository = ProductRepository();
  WishListBloc() : super(WishListState()) {
    on<GetAllWishListIds>(_mapGetAllProductsIds);
    on<AddToWishList>(_mapAddtoWishList);
    // on<ClearProductDetail>((event, emit) {
    //   emit(WishListState(
    //     isLoading: true,
    //     product: null,
    //     hasFetched: false,
    //     isInCart: false,
    //     cartFetched: false,
    //   ));
    // });
  }

  void _mapGetAllProductsIds(
      GetAllWishListIds event, Emitter<WishListState> emit) async {
    emit(state.copyWith(isLoading: true));
    final response = await _productRepository.getWishlistIds();
    if (response is QuerySnapshot) {
      List<WishListModel>? products = [];
      for (var prod in response.docs) {
        products.add(WishListModel.fromFirestore(prod));
      }
      emit(state.copyWith(product: products, isLoading: false));
    } else {
      emit(state.copyWith(isLoading: false, error: response));
    }
  }

  void _mapAddtoWishList(
      AddToWishList event, Emitter<WishListState> emit) async {
    emit(state.copyWith(isWishListing: true));
    String productId = event.productId;
    String banner_image = event.banner_image;
    String title = event.title;
    int price = event.price;
    final response = await _productRepository.addToWishlist(
        productId: productId,
        banner_image: banner_image,
        title: title,
        price: price);

    if (response == "success") {
      print("added to wishlist");
      emit(state.copyWith(isWishListing: false));
      add(GetAllWishListIds());
    }
  }

  // Future<void> _mapGetSingleWishListProduct(GetSingleWishListEvent event,
  //     Emitter<WishListState> emit) async {
  //   String product_id = event.product_id;
  //   // emit(ProductDetailStateLoading());
  //   emit(state.copyWith(
  //     isLoading: true,
  //   ));
  //   final response =
  //       await _productRepository.fetchSingleProduct(product_id: product_id);

  //   // print("printing it from the bloc");
  //   // print(response);

  //   if (response is DocumentSnapshot) {
  //     print("success__________________________________");
  //     print(response);

  //     // emit(SingleProductLoaded(ProductModel.fromFirestore(response)));
  //     emit(state.copyWith(
  //         isLoading: false,
  //         product: ProductModel.fromFirestore(response),
  //         hasFetched: true));
  //   } else if (response is String) {
  //     // emit(ProductDetailFetchErrorState(response.toString()));
  //     emit(state.copyWith(isLoading: false, error: response.toString()));
  //   }
  // }

  // Future<void> _mapWishIsExist(
  //     ProductWishListExitst event, Emitter<WishListState> emit) async {
  //   emit(state.copyWith(isLoading: true, cartFetched: false));
  //   String product_id = event.product_id;
  //   String qtyType = event.qtyType;

  //   // emit(ProductDetailStateLoading());
  //   // emit(state.copyWith(isLoading: true));

  //   final response = await _productRepository.productDetailCartIsExist(
  //       product_id: product_id, qtyType: qtyType);

  //   // print("printing it from the bloc");
  //   // print(response);

  //   if (response is bool) {
  //     // print("success__________________________________");
  //     // print(response);

  //     // emit(ProductCartExist());
  //     emit(state.copyWith(
  //         isLoading: false, isInCart: response, cartFetched: true));
  //   } else if (response is String) {
  //     // emit(ProductDetailFetchErrorState(response.toString()));
  //     emit(state.copyWith(isLoading: false, error: response.toString()));
  //   }
  // }
}
