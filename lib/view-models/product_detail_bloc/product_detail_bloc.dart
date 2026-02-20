import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_app/data/repositories/product_repository.dart';
import 'package:ecom_app/models/product_model/product_model.dart';
import 'package:ecom_app/view-models/product_detail_bloc/prod_details.dart';
// import 'package:ecom_app/view-models/products_bloc/get_products.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final _productRepository = ProductRepository();
  ProductDetailBloc() : super(ProductDetailState()) {
    // on<GetAllProductDetailEvent>(_mapGetAllProducts);
    on<GetSingleProductDetailEvent>(_mapGetSingleProduct);
    on<ProductCartIsExist>(_mapProductCartIsExist);
    on<ClearProductDetail>((event, emit) {
      emit(ProductDetailState(
        isLoading: true,
        product: null,
        hasFetched: false,
        isInCart: false,
        cartFetched: false,
      ));
    });
  }

  Future<void> _mapGetSingleProduct(GetSingleProductDetailEvent event,
      Emitter<ProductDetailState> emit) async {
    String product_id = event.product_id;
    // emit(ProductDetailStateLoading());
    emit(state.copyWith(
      isLoading: true,
    ));
    final response =
        await _productRepository.fetchSingleProduct(product_id: product_id);

    // print("printing it from the bloc");
    // print(response);

    if (response is DocumentSnapshot) {
      print("success__________________________________");
      print(response);

      // emit(SingleProductLoaded(ProductModel.fromFirestore(response)));
      emit(state.copyWith(
          isLoading: false,
          product: ProductModel.fromFirestore(response),
          hasFetched: true));
    } else if (response is String) {
      // emit(ProductDetailFetchErrorState(response.toString()));
      emit(state.copyWith(isLoading: false, error: response.toString()));
    }
  }

  Future<void> _mapProductCartIsExist(
      ProductCartIsExist event, Emitter<ProductDetailState> emit) async {
    emit(state.copyWith(isLoading: true, cartFetched: false));
    String product_id = event.product_id;
    String qtyType = event.qtyType;

    // emit(ProductDetailStateLoading());
    // emit(state.copyWith(isLoading: true));

    final response = await _productRepository.productDetailCartIsExist(
        product_id: product_id, qtyType: qtyType);

    // print("printing it from the bloc");
    // print(response);

    if (response is bool) {
      // print("success__________________________________");
      // print(response);

      // emit(ProductCartExist());
      emit(state.copyWith(
          isLoading: false, isInCart: response, cartFetched: true));
    } else if (response is String) {
      // emit(ProductDetailFetchErrorState(response.toString()));
      emit(state.copyWith(isLoading: false, error: response.toString()));
    }
  }
}
