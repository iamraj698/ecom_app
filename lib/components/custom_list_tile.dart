import 'package:ecom_app/components/my_text.dart';
import 'package:ecom_app/utils/size_config.dart';
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  CustomListTile(
      {super.key,
      // required this.isDarkMode,
      required this.icon,
      required this.title,
      this.trailing,
      this.color});

  // bool isDarkMode;
  Color? color;
  IconData icon;
  String title;
  Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Icon(
          icon,
          size: height(26),
          color: color != null ? color : Color(0xff1D1E20),
        ),
        title: title == "Logout"
            ? MyText(
                title: title,
                fontSize: 15,
                color: color!,
              )
            : MyText(
                title: title,
                fontSize: 15,
              ),
        trailing: trailing);
  }
}
