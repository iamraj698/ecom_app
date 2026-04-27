import 'package:ecom_app/models/order_models/order_model.dart';
import 'package:equatable/equatable.dart';

abstract class OrderState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialState extends OrderState {
  InitialState();
}

class OrderLoading extends OrderState {
  OrderLoading();
}

class OrderSuccessState extends OrderState {
  OrderSuccessState();
}

class OrderErrorState extends OrderState {
  OrderErrorState({required this.error});
  String error;
  @override
  List<Object> get props => [error];
}

class OrdersFetched extends OrderState {
  OrdersFetched({required this.orders});
  List<OrderModel?> orders;
  @override
  List<Object> get props => [OrderModel];
}



class OrdersCancelledState extends OrderState {
  OrdersCancelledState();
}
