abstract class AuthState {}

class AuthInitialState extends AuthState {
  AuthInitialState();
}

class AuthLoadingState extends AuthState {
  AuthLoadingState();
}

class AuthenticatedState extends AuthState {
  AuthenticatedState();
}

class UnAuthenticatedState extends AuthState {
  UnAuthenticatedState();
}

class AuthenticationErrorState extends AuthState {
  String error;
  AuthenticationErrorState({required this.error});
}
