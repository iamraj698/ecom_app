import "package:equatable/equatable.dart";

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AppStarted extends AuthEvent {
  AppStarted();
}

class SignUpEvent extends AuthEvent {
  final String email;
  final String password;
  SignUpEvent({required this.email, required this.password});
  @override
  List<Object> get props => [email, password];
}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;
  SignInEvent({required this.email, required this.password});
  @override
  List<Object> get props => [email, password];
}

class SignOutEvent extends AuthEvent {
  SignOutEvent();
  @override
  List<Object> get props => [];
}
