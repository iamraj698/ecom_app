abstract class ProductDetailEvent {
  @override
  List<Object> get props => [];
}

class GetSingleProductDetailEvent extends ProductDetailEvent {
  GetSingleProductDetailEvent({required this.product_id});
  String product_id;

  List<Object> get props => [product_id];
}

class ProductCartIsExist extends ProductDetailEvent {
  ProductCartIsExist({required this.product_id, required this.qtyType});
  String product_id;
  String qtyType;
  List<Object> get props => [product_id, qtyType];
}

class ClearProductDetail extends ProductDetailEvent {}
