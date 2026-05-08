import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchProduct extends SearchEvent {
  SearchProduct({required this.productName});
  String productName;
  @override
  List<Object> get props => [];
}
