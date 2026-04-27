import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_app/data/repositories/orders_repository.dart';
import 'package:ecom_app/models/cart_item_model/cart_item_model.dart';
import 'package:ecom_app/models/order_models/order_item_model.dart';
import 'package:ecom_app/models/order_models/order_model.dart';
import 'package:ecom_app/view-models/products_bloc/get_products.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'orders.dart';

class OrderBloc extends Bloc<OrdersEvent, OrderState> {
  OrdersRepository _ordersRepository = OrdersRepository();
  OrderBloc() : super(InitialState()) {
    on<PlaceOrder>(_mapPlaceOrder);
    on<FetchAllOrders>(_mapGetAllOrders);
    on<CancelOrder>(_mapCancelOrder);
  }
  void _mapPlaceOrder(PlaceOrder event, Emitter<OrderState> emit) async {
    print("___________________________________________");
    emit(OrderLoading());
    int finalTotal = event.finalTotal;
    List<CartItemModel> cartItems = event.cartItems;
    Map address = event.address;
    double shippingCost = event.shippingCost;
    DateTime orderedOn = event.orderedOn;
    String orderType = event.orderType;
    String? upiId = event.upiId;
    int? cardNumber = event.cardNumber;
    int? validThu = event.validThu;
    int? cvv = event.cvv;
    // String quantityType = event.quantityType;
    print(
        "${finalTotal}, ${cartItems},${address}, ${shippingCost},${orderedOn},${upiId},${cardNumber},${validThu},${orderType},${cvv}");

    final response = await _ordersRepository.placeOrder(
        // quantityType: quantityType,
        finalTotal: finalTotal,
        cartItems: cartItems,
        address: address,
        shippingCost: shippingCost,
        orderedOn: orderedOn,
        orderType: orderType,
        cardNumber: cardNumber,
        cvv: cvv,
        upiId: upiId,
        validThu: validThu);
    if (response is String && response == "success") {
      emit(OrderSuccessState());
    } else {
      emit(OrderErrorState(error: response.toString()));
    }
  }

  void _mapGetAllOrders(FetchAllOrders event, Emitter<OrderState> emit) async {
    emit(OrderLoading());
    final response = await _ordersRepository.getAllOrders();

    if (response is QuerySnapshot) {
      List<OrderModel?> orders = [];
      for (var order in response.docs) {
        orders.add(OrderModel.fromFirestore(order));
      }
      emit(OrdersFetched(orders: orders));
    } else {
      emit(OrderErrorState(error: response.toString()));
    }
  }

  void _mapCancelOrder(CancelOrder event, Emitter<OrderState> emit) async {
    emit(OrderLoading());
    String orderId = event.orderId;
    List<OrderItemModel> orderItems = event.orderItems;

    final response = await _ordersRepository.cancelOrder(
        orderId: orderId, orderItems: orderItems);

    print(response);
    if (response == "cancelled") {
      add(FetchAllOrders());
      emit(OrdersCancelledState());
    } else {
      emit(OrderErrorState(error: response));
    }
  }
}
