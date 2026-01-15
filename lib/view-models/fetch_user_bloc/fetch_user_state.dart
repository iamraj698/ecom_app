import 'package:equatable/equatable.dart';

abstract class FetchUserState extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchUserInitialState extends FetchUserState {}

class FetchUserLoadingState extends FetchUserState {}

class FetchUserSuccessState extends FetchUserState {
  FetchUserSuccessState({required this.data});
  final data;
}

class FetchUserErrorState extends FetchUserState {
  FetchUserErrorState({required this.error});
  String error;
}
