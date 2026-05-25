import 'package:equatable/equatable.dart';

abstract class ChangePasswordState extends Equatable {
  List<Object> get props => [];
}

class ChangePasswordInitial extends ChangePasswordState {
  ChangePasswordInitial();
}

class ChangePasswordLoading extends ChangePasswordState {
  ChangePasswordLoading();
}

class ChangePasswordSuccess extends ChangePasswordState {
  ChangePasswordSuccess();
}

class ChangePasswordError extends ChangePasswordState {
  ChangePasswordError({required this.error});
  String error;
}
