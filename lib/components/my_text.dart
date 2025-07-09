import 'package:ecom_app/utils/size_config.dart';
import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  const MyText({
    super.key,
    required this.title,
    this.fontWeight = FontWeight.normal,
    required this.fontSize,
    this.color = Colors.black,
  });
  final String title;
  final FontWeight fontWeight;
  final double fontSize;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: height(fontSize),
        fontWeight: fontWeight,
        color: color,
        fontFamily: "Inter",
      ),
    );
  }
}
