import 'package:ecom_app/data/repositories/auth_repository.dart';
import 'package:ecom_app/main.dart';
import 'package:ecom_app/routes/routesName.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepository authRepository = AuthRepository();
  FirebaseAuth _auth = FirebaseAuth.instance;
  AuthBloc() : super(AuthInitialState()) {
    on<AppStarted>(appStarted);
    on<SignUpEvent>(signUp);
    on<SignInEvent>(signIn);
    on<SignOutEvent>(signOut);
  }
  void appStarted(AppStarted event, Emitter<AuthState> emit) {
    if (_auth.currentUser != null) {
      emit(AuthenticatedState());
    } else if (_auth.currentUser == null) {
      emit(UnAuthenticatedState());
    }
  }

  void signUp(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    String email = event.email;
    String password = event.password;
    final response = await authRepository.signUp(email, password);
    print("the response of sign up method \n + ${response}");
    if (response != null && response.toString() == email) {
      emit(AuthenticatedState());
      navigatorKey.currentState?.pushReplacementNamed(RouteNames.homepage);
    } else {
      emit(UnAuthenticatedState());
    }
  }

  void signIn(SignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    String email = event.email;
    String password = event.password;
    final response = await authRepository.signIn(email, password);
    print("the response of sign up method \n + ${response}");
    if (response != null && response.toString() == email) {
      emit(AuthenticatedState());
      navigatorKey.currentState?.pushReplacementNamed(RouteNames.homepage);
    } else if (response != null) {
      emit(AuthenticationErrorState(error: response.toString()));
    } else {
      emit(UnAuthenticatedState());
    }
  }

  void signOut(SignOutEvent event, Emitter<AuthState> emit) async {
    await authRepository.signOut().then(
      (value) {
        emit(UnAuthenticatedState());
        navigatorKey.currentState?.pushReplacementNamed(RouteNames.login);
      },
    );
  }
}
