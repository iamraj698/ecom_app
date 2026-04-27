import 'package:ecom_app/models/cart_item_model/cart_item_model.dart';
import 'package:ecom_app/models/order_models/order_item_model.dart';
import 'package:equatable/equatable.dart';

abstract class OrdersEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PlaceOrder extends OrdersEvent {
  PlaceOrder(
      {required this.finalTotal,
      required this.cartItems,
      required this.address,
      required this.shippingCost,
      required this.orderedOn,
      required this.orderType,
      // required this.quantityType,
      this.upiId,
      this.cardNumber,
      this.cvv,
      this.validThu});
  int finalTotal;
  List<CartItemModel> cartItems;
  Map address;
  double shippingCost;
  DateTime orderedOn;
  String orderType;
  String? upiId;
  int? cardNumber;
  int? validThu;
  int? cvv;
  // String quantityType;

  @override
  List<Object?> get props => [
        finalTotal,
        cartItems,
        address,
        shippingCost,
        orderedOn,
        orderType,
        upiId,
        cardNumber,
        validThu,
        cvv,
      ];
}

class FetchAllOrders extends OrdersEvent {
  @override
  List<Object?> get props => [];
}

class CancelOrder extends OrdersEvent {
  CancelOrder({required this.orderId, required this.orderItems});
  String orderId;
  List<OrderItemModel> orderItems;
  @override
  List<Object?> get props => [orderId, orderItems];
}
