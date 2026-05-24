import 'dart:async';

import 'package:ecom_app/data/repositories/auth_repository.dart';
import 'package:ecom_app/main.dart';
import 'package:ecom_app/routes/routesName.dart';
import 'package:ecom_app/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepository authRepository = AuthRepository();
  FirebaseAuth _auth = FirebaseAuth.instance;
  late final StreamSubscription<User?> _authSubscription;

  AuthBloc() : super(AuthInitialState()) {
    on<AppStarted>(appStarted);
    on<AuthUserChanged>(_onAuthUserChanged);
    on<SignUpEvent>(signUp);
    on<SignInEvent>(signIn);
    on<SignOutEvent>(signOut);
    on<ForgotPasswordEvent>(forgotPassword);
  }
  void appStarted(AppStarted event, Emitter<AuthState> emit) {
    _authSubscription = _auth.idTokenChanges().listen((user) {
      print("listening...........");
      print(user);
      AppConstants.user = user;
      add(AuthUserChanged(user));
    });
  }

  // Handle auth state changes here — safe to use emit
  Future<void> _onAuthUserChanged(
      AuthUserChanged event, Emitter<AuthState> emit) async {
    final user = event.user;
    if (user != null) {
      print("authenticated");
      emit(AuthenticatedState());
    } else {
      print("UNauthenticated");
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
      // navigatorKey.currentState?.pushReplacementNamed(RouteNames.homepage);
      // Clear everything and make homepage the new root
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        RouteNames.homepage,
        (Route<dynamic> route) => false,
      );
    } else if (response != null) {
      emit(AuthenticationErrorState(error: response.toString()));
    } else {
      emit(UnAuthenticatedState());
    }
  }

  void signOut(SignOutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    await authRepository.signOut().then(
      (value) {
        emit(UnAuthenticatedState());
        navigatorKey.currentState?.pushReplacementNamed(RouteNames.login);
      },
    );
  }

  Future<void> forgotPassword(
      ForgotPasswordEvent event, Emitter<AuthState> emit) async {
    emit(ForgotPasswordLoadingState());

    try {
      await _auth.sendPasswordResetEmail(email: event.email);

      emit(ForgotPasswordSuccessState());
    } catch (e) {
      emit(ForgotPasswordErrorState(error: e.toString()));
    }
  }
}
