import 'package:ecom_app/components/my_text.dart';
import 'package:ecom_app/utils/custom_styles.dart';
import 'package:ecom_app/utils/size_config.dart';
import 'package:flutter/material.dart';

class LoginTextfield extends StatelessWidget {
  const LoginTextfield(
      {super.key, required this.title, this.hintText, required this.widget});
  final String? hintText;
  final String title;
  final Widget widget;
  

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom:
                  BorderSide(color: CustomStyles.lightGreyText, width: 0.2))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText(
            title: title,
            fontSize: 13,
            color: CustomStyles.lightGreyText,
          ),
          // TextField(
          //   style: TextStyle(fontWeight: FontWeight.w500, fontSize: height(15)),
          //   decoration: InputDecoration(
          //       hintText: hintText,
          //       hintStyle: TextStyle(
          //           fontWeight: FontWeight.w500, fontSize: height(15)),
          //       contentPadding: EdgeInsets.only(left: 0),
          //       border: OutlineInputBorder(borderSide: BorderSide.none)),
          // ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  style: TextStyle(
                      fontWeight: FontWeight.w500, fontSize: height(15)),
                  decoration: InputDecoration(
                      hintText: hintText,
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: height(15)),
                      contentPadding: EdgeInsets.only(left: 0),
                      border: OutlineInputBorder(borderSide: BorderSide.none)),
                ),
              ),

              // Icons
              widget
            ],
          ),
        ],
      ),
    );
  }
}
