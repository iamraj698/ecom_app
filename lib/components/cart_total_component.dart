import 'package:ecom_app/components/my_text.dart';
import 'package:ecom_app/utils/custom_styles.dart';
import 'package:flutter/material.dart';

class CartTotalComponent extends StatelessWidget {
  const CartTotalComponent({
    super.key,
    required this.title,
    required this.cost,
  });
  final String title;
  final String cost;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MyText(
          title: title,
          fontSize: 15,
          color: CustomStyles.lightGreyText,
        ),
        MyText(
          title: cost,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        )
      ],
    );
  }
}
