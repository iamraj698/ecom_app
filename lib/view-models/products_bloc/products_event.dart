abstract class ProductsEvent {
  @override
  List<Object> get props => [];
}

class GetAllProductsEvent extends ProductsEvent {}

class GetSingleProductDetailEvent extends ProductsEvent {
  GetSingleProductDetailEvent({required this.product_id});
  String product_id;

  List<Object> get props => [product_id];
}
