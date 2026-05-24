import 'package:ecom_app/components/login_textfield.dart';
import 'package:ecom_app/components/my_text.dart';
import 'package:ecom_app/main.dart';
import 'package:ecom_app/routes/routesName.dart';
import 'package:ecom_app/utils/custom_styles.dart';
import 'package:ecom_app/utils/size_config.dart';
import 'package:ecom_app/view-models/auth_bloc/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is ForgotPasswordSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Password reset email sent")),
          );

          Navigator.pop(context); // back to login
        }

        if (state is ForgotPasswordErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      child: Scaffold(
        // appBar: AppBar(title: MyText(title: "Forgot Password", fontSize: 17),),
        body: Padding(
          padding: EdgeInsets.all(width(20)),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const MyText(title: "Forgot Password", fontSize: 24),
                SizedBox(
                  height: height(10),
                ),
                MyText(
                  title: "Enter Your Email to get password reset link.",
                  fontSize: 14,
                  color: CustomStyles.lightGreyText,
                ),
                SizedBox(
                  height: height(30),
                ),
                LoginTextfield(
                  controller: emailController,
                  title: "Email",
                  widget: const Icon(
                    Icons.mail,
                    color: CustomStyles.lightGreen,
                  ),
                  hintText: "Please Enter Your Email",
                ),

                SizedBox(
                  height: height(15),
                ),

                // Submitbtn
                ElevatedButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(ForgotPasswordEvent(
                        email: emailController.text.toString()));
                  },
                  child: MyText(
                    title: "Submit",
                    fontSize: 14,
                    color: CustomStyles.textWhite,
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: CustomStyles.submit),
                ),

                SizedBox(
                  height: height(20),
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Sign Up Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyText(
                          title: "Go back to ",
                          fontSize: 13,
                          color: CustomStyles.lightGreyText,
                        ),
                        SizedBox(
                          width: width(2),
                        ),
                        InkWell(
                          onTap: () {
                            print("go to login page");
                            Navigator.pop(context);
                          },
                          child: MyText(
                            title: "Login",
                            fontSize: 13,
                            color: CustomStyles.textBlack,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
