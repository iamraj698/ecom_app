import 'package:ecom_app/utils/custom_styles.dart';
import 'package:ecom_app/utils/size_config.dart';
import 'package:flutter/material.dart';

class RatingStar extends StatelessWidget {
  RatingStar({super.key, this.color = CustomStyles.ratingFilled, this.size});

  Color? color;
  double? size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Icon(
          size: (size != null) ? size : height(13), Icons.star, color: color),
    );
  }
}
