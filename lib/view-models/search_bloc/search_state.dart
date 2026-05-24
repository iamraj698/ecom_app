import 'package:ecom_app/models/product_model/product_model.dart';
import 'package:equatable/equatable.dart';

abstract class SearchState extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchStateInitial extends SearchState {}

class SearchStateLoading extends SearchState {}

class SearchProductsFetchErrorState extends SearchState {
  SearchProductsFetchErrorState(this.error);
  String error;
}

class SearchStateSuccess extends SearchState {
  SearchStateSuccess(this.products);
  var products;
}


class SearchSuccessEmptyData extends SearchState {}