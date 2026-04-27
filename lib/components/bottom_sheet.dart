import 'package:ecom_app/components/my_text.dart';
import 'package:ecom_app/utils/custom_styles.dart';
import 'package:ecom_app/utils/size_config.dart';
import 'package:flutter/material.dart';

class CustomBottomSheet {
  bottomSheet(context, Widget widget) {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
            height: height(400),
            width: double.infinity,
            decoration: BoxDecoration(
                color: CustomStyles.cartImagBack,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(width(100)),
                  topRight: Radius.circular(width(100)),
                )),
            child: widget);
      },
    );
  }
}
