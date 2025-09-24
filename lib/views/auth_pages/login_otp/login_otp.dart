import 'package:ecom_app/components/submit.dart';
import 'package:ecom_app/main.dart';
import 'package:ecom_app/routes/routesName.dart';
import 'package:ecom_app/utils/custom_styles.dart';
import 'package:ecom_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class LoginOtp extends StatefulWidget {
  const LoginOtp({super.key});

  @override
  State<LoginOtp> createState() => _LoginOtpState();
}

class _LoginOtpState extends State<LoginOtp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomStyles.cartImagBack,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(height(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "./assets/images/otp.png",
                width: width(300),
                height: height(300),
              ),
              PinCodeTextField(
                appContext: context,
                length: 6,
                // obscureText: true,
                animationType: AnimationType.none,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  activeColor: Colors.blue,
                  inactiveColor: Colors.grey,
                ),
                onChanged: (value) {
                  print(value);
                },
              ),
              SizedBox(
                height: height(20),
              ),
              Submit(
                  submitText: "Submit",
                  onTap: () {
                    navigatorKey.currentState?.pushReplacementNamed(RouteNames.homepage);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
