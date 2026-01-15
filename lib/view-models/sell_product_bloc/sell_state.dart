import 'package:equatable/equatable.dart';

class SellState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SellInitialState extends SellState {}

class SellAddPrdLoading extends SellState {}

class SellAddProdSuccess extends SellState {}

class SellAddProdError extends SellState {
  SellAddProdError({required this.error});
  String error;
}
