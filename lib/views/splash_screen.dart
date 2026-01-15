import 'dart:async';
import 'package:ecom_app/main.dart';
import 'package:ecom_app/routes/routesName.dart';
import 'package:ecom_app/utils/size_config.dart';
import 'package:ecom_app/view-models/auth_bloc/auth.dart';
import 'package:ecom_app/view-models/fetch_user_bloc/fetch_user_bloc.dart';
import 'package:ecom_app/view-models/fetch_user_bloc/fetch_user_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () {
      context.read<AuthBloc>().add(AppStarted());
      // navigatorKey.currentState?.pushReplacementNamed(RouteNames.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        print(state);
        if (state is AuthenticatedState) {
          context.read<FetchUserBloc>().add(FetchUserProfile());
          navigatorKey.currentState?.pushReplacementNamed(RouteNames.homepage);
        } else {
          navigatorKey.currentState?.pushReplacementNamed(RouteNames.login);
        }
      },
      child: Scaffold(
        backgroundColor: Color(0xff9775FA),
        body: Center(
          child: Image.asset(
            "./assets/images/Logo_White.png",
            height: height(200),
            width: width(200),
          ),
        ),
      ),
    );
    // return Scaffold(
    //   backgroundColor: Color(0xff9775FA),
    //   body: Center(
    //     child: Image.asset(
    //       "./assets/images/Logo_White.png",
    //       height: height(200),
    //       width: width(200),
    //     ),
    //   ),
    // );
  }
}
