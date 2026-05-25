import 'package:equatable/equatable.dart';

abstract class ChangePasswordEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ChangePassword extends ChangePasswordEvent {
  ChangePassword({required this.currentPassword, required this.password});
  String password;
  String currentPassword;
  List<Object> get props => ['currentPassword,password'];
}
