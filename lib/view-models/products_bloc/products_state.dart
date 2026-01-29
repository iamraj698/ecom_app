import 'package:ecom_app/models/product_model/product_model.dart';

abstract class ProductsState {
  @override
  List<Object> get props => [];
}

class ProductsStateInitial extends ProductsState {}

class ProductsStateLoading extends ProductsState {}

class ProductsFetchErrorState extends ProductsState {
  ProductsFetchErrorState(this.error);
  String error;
}

class ProductsStateSuccess extends ProductsState {
  ProductsStateSuccess(this.products);
  var products;
}

class SingleProductLoaded extends ProductsState {
  SingleProductLoaded(this.product);
  ProductModel product;
  List<Object> get prop => [product];
}
