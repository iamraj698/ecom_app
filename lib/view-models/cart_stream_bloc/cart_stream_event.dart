import 'package:equatable/equatable.dart';

abstract class CartStreamEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchCartItems extends CartStreamEvent {
  FetchCartItems();
}
