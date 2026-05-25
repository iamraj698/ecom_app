import 'package:ecom_app/components/alert_widget.dart';
import 'package:ecom_app/components/login_textfield.dart';
import 'package:ecom_app/components/my_text.dart';
import 'package:ecom_app/main.dart';
import 'package:ecom_app/utils/custom_styles.dart';
import 'package:ecom_app/utils/size_config.dart';
import 'package:ecom_app/view-models/change_pass_bloc/change_pass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChnagePassword extends StatefulWidget {
  const ChnagePassword({super.key});

  @override
  State<ChnagePassword> createState() => _ChnagePasswordState();
}

class _ChnagePasswordState extends State<ChnagePassword> {
  bool obscuredText = true;
  bool obscuredIcon = true;
  TextEditingController currentPasswordController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<ChangePassBloc, ChangePasswordState>(
      listener: (context, state) {
        if (state is ChangePasswordSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Password changed Successfully")),
          );
          navigatorKey.currentState?.pop();
        }
        if (state is ChangePasswordError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Change Password",
            style: TextStyle(
                fontFamily: "Inter", fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(width(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoginTextfield(
                  title: "Current Password",
                  obscuredText: obscuredText,
                  hintText: "Current Password",
                  controller: currentPasswordController,
                  widget: InkWell(
                    onTap: () {
                      setState(() {
                        obscuredText = !obscuredText;
                        obscuredIcon = !obscuredIcon;
                      });
                    },
                    child: Icon(
                      obscuredIcon == true
                          ? Icons.remove_red_eye
                          : Icons.remove_red_eye_outlined,
                      color: CustomStyles.lightGreen,
                    ),
                  ),
                ),
                SizedBox(
                  height: height(10),
                ),
                LoginTextfield(
                  title: "New Password",
                  obscuredText: obscuredText,
                  hintText: "New Password",
                  controller: passwordController,
                  widget: InkWell(
                    onTap: () {
                      setState(() {
                        obscuredText = !obscuredText;
                        obscuredIcon = !obscuredIcon;
                      });
                    },
                    child: Icon(
                      obscuredIcon == true
                          ? Icons.remove_red_eye
                          : Icons.remove_red_eye_outlined,
                      color: CustomStyles.lightGreen,
                    ),
                  ),
                ),
                SizedBox(
                  height: height(20),
                ),
                BlocBuilder<ChangePassBloc, ChangePasswordState>(
                  builder: (context, state) {
                    if (state is ChangePasswordLoading) {
                      return SizedBox(
                        height: height(30),
                        width: width(30),
                        child: CircularProgressIndicator(),
                      );
                    }
                    return SizedBox(
                      width: width(200),
                      child: ElevatedButton(
                        onPressed: () {
                          if (currentPasswordController.text != "" ||
                              passwordController.text != "") {
                            context.read<ChangePassBloc>().add(ChangePassword(
                                currentPassword: currentPasswordController.text,
                                password: passwordController.text));
                          } else {
                            alertWidget(context,
                                "Please Enter Cuurent and New Passwords to Procede ");
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: CustomStyles.submit),
                        child: MyText(
                          title: "Change Password",
                          fontSize: 14,
                          color: CustomStyles.textWhite,
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
