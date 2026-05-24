import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_app/data/repositories/product_repository.dart';
import 'package:ecom_app/models/product_model/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'search.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  ProductRepository _productRepository = ProductRepository();
  SearchBloc() : super(SearchStateInitial()) {
    on<SearchProduct>(_mapSearchProduct);

    // on<GetSingleProductDetailEvent>(_mapGetSingleProduct);
  }
  void _mapSearchProduct(SearchProduct event, Emitter<SearchState> emit) async {
    emit(SearchStateLoading());
    String productName = event.productName;

    final response = await _productRepository.searchProduct(name: productName);
    List<ProductModel?> productList = [];
    if (response is QuerySnapshot) {
      for (var prod in response.docs) {
        productList.add(ProductModel.fromFirestore(prod));
      }
      if (productList.isNotEmpty) {
        emit(SearchStateSuccess(productList));
      } else {
        emit(SearchSuccessEmptyData());
      }
    } else {
      emit(SearchProductsFetchErrorState(response.toString()));
    }
  }
}
