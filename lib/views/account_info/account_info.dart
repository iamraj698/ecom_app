import 'package:ecom_app/components/my_text.dart';
import 'package:ecom_app/main.dart';
import 'package:ecom_app/routes/routesName.dart';
import 'package:ecom_app/utils/app_constants.dart';
import 'package:ecom_app/utils/custom_styles.dart';
import 'package:ecom_app/utils/size_config.dart';
import 'package:ecom_app/view-models/auth_bloc/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountInfo extends StatefulWidget {
  const AccountInfo({super.key});

  @override
  State<AccountInfo> createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: SafeArea(
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: width(7)),
                  child: Container(
                      decoration: BoxDecoration(
                          color: const Color(
                            0xffF5F6FA,
                          ),
                          borderRadius: BorderRadius.circular(width(30))),
                      height: height(40),
                      width: width(40),
                      child: IconButton(
                          onPressed: () {
                            navigatorKey.currentState?.pop();
                          },
                          icon: const Icon(
                            Icons.home_outlined,
                            size: 27,
                          ))),
                ),
                const MyText(
                  title: "Account Information",
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
                IconButton(
                  onPressed: () {
                    // navigatorKey.currentState?.pop();
                    context.read<AuthBloc>().add(SignOutEvent());
                  },
                  icon: const Icon(Icons.logout),
                  color: Colors.red,
                )
              ],
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyText(
              title: "User Details",
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              height: height(10),
            ),
            Container(
              padding: EdgeInsets.all(width(40)),
              margin: EdgeInsets.only(left: width(30), right: width(30)),
              decoration: BoxDecoration(
                  // border: Border.all(color: Colors.black),
                  color: CustomStyles.lightBlueColor,
                  borderRadius: BorderRadius.circular(width(15))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const MyText(
                              title: "Name :",
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(
                              width: width(10),
                            ),
                            MyText(
                              title: AppConstants.userDetails
                                      .containsKey("userName")
                                  ? AppConstants.userDetails["userName"] != ""
                                      ? AppConstants.userDetails["userName"]
                                      : "Undfined"
                                  : "Undefined",
                              fontSize: 18,
                              // fontWeight: FontWeight.bold,
                            )
                          ],
                        ),

                        SizedBox(
                          height: height(10),
                        ),
                        // EMail

                        Row(
                          children: [
                            const MyText(
                              title: "Email :",
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(
                              width: width(10),
                            ),
                            Expanded(
                              child: MyText(
                                title: AppConstants.user!.email! ?? "Undefined",
                                fontSize: 18,
                                maxLines: 3,

                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height(10),
                        ),

                        // DOB

                        Row(
                          children: [
                            const MyText(
                              title: "Date of Birth :",
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(
                              width: width(10),
                            ),
                            MyText(
                              title: AppConstants.userDetails.containsKey("dob")
                                  ? AppConstants.userDetails["dob"] != ""
                                      ? AppConstants.userDetails["dob"]
                                      : "Undfined"
                                  : "Undefined",
                              fontSize: 18,
                              // fontWeight: FontWeight.bold,
                            )
                          ],
                        )
                      ],
                      // Button to Edit User Profile
                    ),
                  ),
                ],
              ),
            ),
            AppConstants.userDetails.containsKey("userName")
                ? AppConstants.userDetails["userName"] != ""
                    ? SizedBox()
                    : MyText(
                        title: "Kindly Update Your Details",
                        fontSize: 14,
                        color: Colors.red,
                      )
                : SizedBox(),
            // parent
            SizedBox(
              height: height(30),
            ),

            SizedBox(
              width: width(200),
              child: ElevatedButton(
                onPressed: () {
                  navigatorKey.currentState?.pushNamed(RouteNames.editProfile,
                      arguments: {"userId": AppConstants.user?.uid});
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: CustomStyles.submit),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.edit_square,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: width(10),
                    ),
                    MyText(
                      title: "Edit Profile",
                      fontSize: 14,
                      color: CustomStyles.textWhite,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
