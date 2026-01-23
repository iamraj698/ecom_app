import 'package:ecom_app/data/repositories/product_repository.dart';
import 'package:ecom_app/main.dart';
import 'package:ecom_app/models/cart_item_model/cart_item_model.dart';
import 'package:ecom_app/routes/routesName.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_stream.dart';

class CartStreamBloc extends Bloc<CartStreamEvent, CartStreamState> {
  ProductRepository _productRepository = ProductRepository();
  CartStreamBloc() : super(CartStreamStateInitial()) {
    on<FetchCartItems>(_mapFetchCartItems);
  }

// fetch the cart items streams

  void _mapFetchCartItems(
      FetchCartItems event, Emitter<CartStreamState> emit) async {
    emit(CartStreamStateLoading());
    await emit.forEach(
      _productRepository.fetchCartItems(),
      onData: (snapshot) {
        List<CartItemModel> cartItems = snapshot.docs.map<CartItemModel>((doc) {
          return CartItemModel.fromDocument(doc);
        }).toList();
        for (var item in cartItems) {
          print(item.id);
        }
        return CartStreamLoaded(cartItems: cartItems);
      },
      onError: (error, stackTrace) {
        return CartStreamError(error.toString());
      },
    );
  }
}
