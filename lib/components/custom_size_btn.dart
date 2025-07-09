import 'package:ecom_app/components/my_text.dart';
import 'package:ecom_app/utils/custom_styles.dart';
import 'package:ecom_app/utils/size_config.dart';
import 'package:flutter/material.dart';

class CustomSizeBtn extends StatelessWidget {
  const CustomSizeBtn({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: CustomStyles.sizeBtn, // ✅
      child: InkWell(
        hoverColor: Colors.black,
        onTap: () {
          print("clicked");
        },
        child: Container(
          width: width(60),
          height: height(60),
          // decoration: BoxDecoration(
          //   color: CustomStyles.sizeBtn,
          // ),
          child: Center(
            child: MyText(
              title: title,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
