import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_app/data/repositories/product_repository.dart';
import 'package:ecom_app/models/product_model/product_model.dart';
import 'package:ecom_app/view-models/products_bloc/get_products.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final _productRepository = ProductRepository();
  ProductsBloc() : super(ProductsStateInitial()) {
    on<GetAllProductsEvent>(_mapGetAllProducts);
    on<GetSingleProductDetailEvent>(_mapGetSingleProduct);
  }
  Future<void> _mapGetAllProducts(
      GetAllProductsEvent event, Emitter<ProductsState> emit) async {
    emit(ProductsStateLoading());
    final response = await _productRepository.fetchProducts();

    // print("printing it from the bloc");
    // print(response);

    if (response is QuerySnapshot) {
      print(response);
      emit(ProductsStateSuccess(response));
    } else if (response.isEmpty) {
      emit(ProductsStateSuccess(""));
    } else if (response is String) {
      emit(ProductsFetchErrorState(response.toString()));
    }
  }

  Future<void> _mapGetSingleProduct(
      GetSingleProductDetailEvent event, Emitter<ProductsState> emit) async {
    String product_id = event.product_id;
    emit(ProductsStateLoading());
    final response =
        await _productRepository.fetchSingleProduct(product_id: product_id);

    // print("printing it from the bloc");
    // print(response);

    if (response is DocumentSnapshot) {
      print("success__________________________________");
      print(response);

      emit(SingleProductLoaded(ProductModel.fromFirestore(response)));
    } else if (response.isEmpty) {
      emit(ProductsStateSuccess("Something went wrong"));
    } else if (response is String) {
      emit(ProductsFetchErrorState(response.toString()));
    }
  }
}
