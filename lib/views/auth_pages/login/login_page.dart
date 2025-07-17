import 'package:ecom_app/components/custom_list_tile.dart';
import 'package:ecom_app/components/login_textfield.dart';
import 'package:ecom_app/components/my_text.dart';
import 'package:ecom_app/components/submit.dart';
import 'package:ecom_app/main.dart';
import 'package:ecom_app/utils/custom_styles.dart';
import 'package:ecom_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:ecom_app/routes/routesName.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isRememberMe = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  const LoginTextfield(
                    hintText: "Esther Howard",
                    title: "Username",
                    widget: Icon(
                      Icons.check,
                      color: CustomStyles.lightGreen,
                    ),
                  ),
                  SizedBox(
                    height: height(10),
                  ),

                  const LoginTextfield(
                    hintText: "HJ@#9783kja",
                    title: "Password",
                    widget: MyText(
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
                      MyText(title: "Remember Me", fontSize: 15),
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
                              isRememberMe ? Icons.toggle_off : Icons.toggle_on,
                              size: width(50),
                              color: isRememberMe
                                  ? Color(0xffD6D6D6)
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
            )
          ],
        ),
      ),
      bottomNavigationBar: Submit(
        submitText: "Login",
        onTap: () {
          navigatorKey.currentState?.pushNamed(RouteNames.homepage);
        },
      ),
    );
  }
}
