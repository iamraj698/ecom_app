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
