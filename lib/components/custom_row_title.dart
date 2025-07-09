import 'package:ecom_app/components/my_text.dart';
import 'package:flutter/material.dart';

class CustomRowTitle extends StatelessWidget {
  CustomRowTitle(
      {super.key, required this.title, required this.subTitle, this.onTap});
  final VoidCallback? onTap;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MyText(
          title: title,
          fontWeight: FontWeight.bold,
          fontSize: 17,
          color: Color(0xff1D1E20),
        ),
        InkWell(
          onTap: onTap,
          child: MyText(
            title: subTitle,
            fontSize: 13,
            color: Color(0xff8F959E),
          ),
        )
      ],
    );
  }
}
