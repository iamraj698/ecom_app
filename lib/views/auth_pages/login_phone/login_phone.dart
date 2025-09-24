import 'package:ecom_app/components/login_textfield.dart';
import 'package:ecom_app/components/my_text.dart';
import 'package:ecom_app/components/submit.dart';
import 'package:ecom_app/main.dart';
import 'package:ecom_app/routes/routesName.dart';
import 'package:ecom_app/utils/custom_styles.dart';
import 'package:ecom_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class LoginPhone extends StatefulWidget {
  const LoginPhone({super.key});

  @override
  State<LoginPhone> createState() => _LoginPhoneState();
}

class _LoginPhoneState extends State<LoginPhone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: MyText(
      //     title: "Login",
      //     fontSize: 22,
      //     fontWeight: FontWeight.w500,
      //   ),
      //   centerTitle: true,
      // ),
      backgroundColor: CustomStyles.cartImagBack,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(height(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "./assets/images/person.png",
                  height: height(220),
                ),
                LoginTextfield(
                  title: "Phone ",
                  widget: Icon(Icons.phone_android),
                  hintText: "Phone Number",
                ),
                SizedBox(
                  height: height(20),
                ),
                Submit(
                    submitText: "Login",
                    onTap: () {
                      navigatorKey.currentState?.pushReplacementNamed(RouteNames.loginOtp);
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
