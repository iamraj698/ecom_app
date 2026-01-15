import 'package:ecom_app/components/alert_widget.dart';
import 'package:ecom_app/components/login_textfield.dart';
import 'package:ecom_app/components/my_text.dart';
import 'package:ecom_app/components/submit.dart';
import 'package:ecom_app/utils/custom_styles.dart';
import 'package:ecom_app/utils/size_config.dart';
import 'package:ecom_app/view-models/edit_profile_block/edit.dart';
import 'package:ecom_app/view-models/fetch_user_bloc/fetch_user_bloc.dart';
import 'package:ecom_app/view-models/fetch_user_bloc/fetch_user_event.dart';
import 'package:ecom_app/view-models/fetch_user_bloc/fetch_user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late String userUid;
  bool _isLoaded = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  DateTime? pickedDate;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    if (_isLoaded == false) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
      userUid = args["userId"];
      print("the user ID printing from edit profile ${userUid}");
      context.read<FetchUserBloc>().add(FetchUserProfile());
      _isLoaded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FetchUserBloc, FetchUserState>(
      listener: (context, state) {
        print(state);
        if (state is FetchUserSuccessState) {
          final user = state.data;
          nameController.text = user['userName'];
          emailController.text = user['email'];
          if (user['dob'] == "") {
            dobController.text = "Select your birth date";
          } else {
            dobController.text = user['dob'];
            pickedDate = DateFormat("dd-MM-yyy").parse(user['dob']);
            print("picked Date ${pickedDate}");
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const MyText(title: "Edit Profile", fontSize: 17),
        ),
        body: Padding(
          padding: EdgeInsets.all(width(20)),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // parent column
              children: [
                Column(
                  children: [
                    const MyText(
                      title: "Complete / Edit Profile",
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    MyText(
                      title: "Please Provide Below Information",
                      fontSize: 14,
                      color: CustomStyles.lightGreyText,
                    )
                  ],
                ),
                SizedBox(
                  height: height(60),
                ),
                LoginTextfield(
                  title: "User Name",
                  widget: SizedBox(),
                  controller: nameController,
                ),

                SizedBox(
                  height: height(10),
                ),
                AbsorbPointer(
                  child: LoginTextfield(
                    title: "Email",
                    widget: SizedBox(),
                    controller: emailController,
                  ),
                ),

                SizedBox(
                  height: height(10),
                ),

                // ElevatedButton(
                //     onPressed: () {},
                //     style: ElevatedButton.styleFrom(
                //         shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.zero),
                //         backgroundColor: CustomStyles.cartBtnText,
                //         shadowColor: Colors.transparent,
                //         alignment: Alignment.center),
                //     child: MyText(
                //       title: "Select Date of Birth",
                //       fontSize: 14,
                //     )),

                InkWell(
                  onTap: () async {
                    pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );

                    if (pickedDate != null) {
                      print("picked date ${pickedDate}");
                      setState(() {});
                      dobController.text =
                          "${pickedDate!.day}-${pickedDate!.month}-${pickedDate!.year}";
                    }
                  },
                  child: AbsorbPointer(
                    child: LoginTextfield(
                      title: "Date of Birth",
                      widget: const SizedBox(),
                      controller: dobController,
                    ),
                  ),
                )

                // InkWell(
                //   onTap: (){
                //     print("clicked");

                //   },
                //   child: LoginTextfield(
                //     title: "Date of Birth",
                //     widget: SizedBox(),
                //     controller: dobController,
                //   ),
                // ),
                // LoginTextfield(title: "User Name", widget: SizedBox())
              ]),
        ),
        bottomNavigationBar: Submit(
            submitText: "Save",
            onTap: () {
              if (nameController.text == "" ||
                  emailController.text == "" ||
                  pickedDate == null) {
                alertWidget(context, "above fields should not be empty");
              } else {
                context.read<EditProfileBloc>().add(EditUserInfo(
                    uid: userUid,
                    userName: nameController.text,
                    email: emailController.text,
                    dob: pickedDate!));
              }
            }),
      ),
    );
  }
}
