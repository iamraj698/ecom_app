import 'package:ecom_app/components/login_textfield.dart';
import 'package:ecom_app/components/my_text.dart';
import 'package:ecom_app/components/submit.dart';
import 'package:ecom_app/main.dart';
import 'package:ecom_app/utils/custom_styles.dart';
import 'package:ecom_app/utils/size_config.dart';
import 'package:ecom_app/view-models/auth_bloc/auth.dart';
import 'package:flutter/material.dart';
import 'package:ecom_app/routes/routesName.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isRememberMe = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthenticationErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.error),
            backgroundColor: Colors.red,
            action: SnackBarAction(
                label: "OK",
                textColor: Colors.white,
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  print("pressed Ok");
                }),
          ));
        }
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: EdgeInsets.all(width(20)),
          child: Column(
            // main parent column
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      const MyText(
                        title: "Welcome",
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                      MyText(
                        title: "Please enter your data to continue",
                        fontSize: 15,
                        color: CustomStyles.lightGreyText,
                      ),
                    ],
                  )
                ],
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // user name
                    LoginTextfield(
                      controller: emailController,
                      hintText: "Enter Your Email",
                      title: "Username",
                      widget: const Icon(
                        Icons.check,
                        color: CustomStyles.lightGreen,
                      ),
                    ),
                    SizedBox(
                      height: height(10),
                    ),

                    LoginTextfield(
                      controller: passwordController,
                      obscuredText: true,
                      hintText: "Enter Your Password",
                      title: "Password",
                      widget: const MyText(
                        title: "Strong",
                        fontSize: 13,
                        color: CustomStyles.lightGreen,
                      ),
                    ),

                    SizedBox(
                      height: height(10),
                    ),

                    const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MyText(
                          title: "Forgot Password?",
                          fontSize: 15,
                          color: CustomStyles.danger,
                        )
                      ],
                    ),

                    SizedBox(
                      height: height(10),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const MyText(title: "Remember Me", fontSize: 15),
                        ToggleButtons(
                          renderBorder: false,
                          splashColor: Colors.transparent,
                          borderColor: Colors.transparent,
                          fillColor: Colors.transparent,
                          isSelected: [isRememberMe],
                          onPressed: (int index) {
                            setState(() {
                              isRememberMe = !isRememberMe;
                              // toggle disabled
                              // isDarkMode = isDarkMode;
                            });
                          },
                          children: [
                            Icon(
                                isRememberMe
                                    ? Icons.toggle_off
                                    : Icons.toggle_on,
                                size: width(50),
                                color: isRememberMe
                                    ? const Color(0xffD6D6D6)
                                    : CustomStyles.lightGreen),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              //  terms And conditions

              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Sign Up Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyText(
                        title: "Didn't have an account ",
                        fontSize: 13,
                        color: CustomStyles.lightGreyText,
                      ),
                      SizedBox(
                        width: width(2),
                      ),
                      InkWell(
                        onTap: () {
                          print("go to sign up page");
                          navigatorKey.currentState
                              ?.pushReplacementNamed(RouteNames.signUp);
                        },
                        child: MyText(
                          title: "Sign Up",
                          fontSize: 13,
                          color: CustomStyles.textBlack,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),

                  SizedBox(
                    height: height(10),
                  ),

                  RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text:
                              "By connecting your account confirm that you agree with our ",
                          style: TextStyle(
                              color: CustomStyles.lightGreyText,
                              fontSize: height(13)),
                          children: [
                            TextSpan(
                              text: "Term and Condition",
                              style: TextStyle(
                                  color: CustomStyles.textBlack,
                                  fontWeight: FontWeight.w600,
                                  fontSize: height(13)),
                            )
                          ]))
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: Submit(
          submitText: "Login",
          onTap: () {
            // navigatorKey.currentState?.pushReplacementNamed(RouteNames.homepage);
            print(emailController.text.toString() +
                " " +
                passwordController.text.toString());
            if (emailController.text.toString() != "" &&
                passwordController.text.toString() != "") {
              context.read<AuthBloc>().add(SignInEvent(
                  email: emailController.text.toString(),
                  password: passwordController.text.toString()));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Please Enter The Credentials"),
                backgroundColor: Colors.red,
                action: SnackBarAction(
                    label: "OK",
                    textColor: Colors.white,
                    onPressed: () {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      print("pressed Ok");
                    }),
              ));
            }
          },
        ),
      ),
    );
  }
}
