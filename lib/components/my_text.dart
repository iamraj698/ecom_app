import 'package:ecom_app/utils/size_config.dart';
import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  const MyText({
    super.key,
    required this.title,
    this.fontWeight = FontWeight.normal,
    required this.fontSize,
    this.color = Colors.black,
    this.maxLines = null,
  });
  final String title;
  final FontWeight fontWeight;
  final double fontSize;
  final Color color;
  final int? maxLines;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      maxLines: maxLines,
      // overflow: TextOverflow.ellipsis,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: TextStyle(
        fontSize: height(fontSize),
        fontWeight: fontWeight,
        color: color,
        fontFamily: "Inter",
      ),
    );
  }
}
