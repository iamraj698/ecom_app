import 'package:ecom_app/data/repositories/product_repository.dart';
import 'package:ecom_app/main.dart';
import 'package:ecom_app/models/cart_item_model/cart_item_model.dart';
import 'package:ecom_app/routes/routesName.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  ProductRepository _productRepository = ProductRepository();
  CartBloc() : super(CartStateInitial()) {
    on<AddCartProduct>(_mapAddToCart);
    on<DeleteCartItem>(_mapDeleteCartItem);
    on<IncrementCartItem>(_mapIncrementCartItem);
    on<DecrementCartItem>(_mapDecrementCartItem);

    // on<FetchCartItems>(_mapFetchCartItems);
  }
  void _mapAddToCart(AddCartProduct event, Emitter<CartState> emit) async {
    emit(CartStateLoading());
    String productId = event.productId;
    String title = event.title;
    int priceAtTime = event.priceAtTime;
    String createdAt = event.createdAt;
    String banner_image = event.banner_image;

    int quantity = event.quantity;
    String qtyType = event.qtyType;

    final response = await _productRepository.addToCart(
        productId: productId,
        title: title,
        priceAtTime: priceAtTime,
        createdAt: createdAt,
        quantity: quantity,
        banner_image: banner_image,
        qtyType: qtyType);
    print("response is ______________________ ${response}");

    if (response is String && response == "success") {
      print("emit success");
      emit(CartStateSuccess());
    } else if (response == "Only 4 quantity are allowed in the cart") {
      emit(CartProductError(response.toString()));
    } else if (response == null) {
      emit(CartProductError("Error"));
    } else {
      CartProductError(response);
    }
  }

  // delete cart Item
  void _mapDeleteCartItem(DeleteCartItem event, Emitter<CartState> emit) async {
    final cartItemId = event.cartProdId;
    emit(CartStateLoading());
    final response =
        await _productRepository.deleteCartItem(cartItemId: cartItemId);

    if (response == "success") {
      emit(CartStateSuccess());
    } else {
      emit(CartProductError(response));
    }
  }

// Increment cart Item

  // delete cart Item
  void _mapIncrementCartItem(
      IncrementCartItem event, Emitter<CartState> emit) async {
    final cartItemId = event.cartProdId;
    emit(CartStateLoading());
    final response =
        await _productRepository.incrementCartItem(cartItemId: cartItemId);

    print("cart bloc ______________________________");
    print(response);

    if (response == "success") {
      emit(CartStateSuccess());
    } else {
      emit(CartProductError(response));
    }
  }

  // Decrement the cart Item

  void _mapDecrementCartItem(
      DecrementCartItem event, Emitter<CartState> emit) async {
    final cartItemId = event.cartProdId;
    emit(CartStateLoading());
    final response =
        await _productRepository.decrementCartItem(cartItemId: cartItemId);

    print("cart bloc ______________________________");
    print(response);

    if (response == "success") {
      emit(CartStateSuccess());
    } else {
      emit(CartProductError(response));
    }
  }

// fetch the cart items streams

//   void _mapFetchCartItems(FetchCartItems event, Emitter<CartState> emit) async {
//     emit(CartStateLoading());
//     await emit.forEach(
//       _productRepository.fetchCartItems(),
//       onData: (snapshot) {
//         List<CartItemModel> cartItems = snapshot.docs.map<CartItemModel>((doc) {
//           return CartItemModel.fromDocument(doc);
//         }).toList();
//         for (var item in cartItems) {
//           print(item.id);
//         }
//         return CartLoaded(cartItems: cartItems);
//       },
//       onError: (error, stackTrace) {
//         return CartProductError(error.toString());
//       },
//     );
//   }
}
