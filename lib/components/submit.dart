import 'package:ecom_app/components/my_text.dart';
import 'package:ecom_app/utils/custom_styles.dart';
import 'package:ecom_app/utils/size_config.dart';
import 'package:flutter/material.dart';

class Submit extends StatelessWidget {
  const Submit({super.key, required this.submitText, required this.onTap});
  final String submitText;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: CustomStyles.submit,
      child: InkWell(
        splashColor: CustomStyles.submit,
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: height(60),
          child: Center(
              child: MyText(
            title: submitText,
            fontSize: 17,
            color: CustomStyles.textWhite,
            fontWeight: FontWeight.w500,
          )),
        ),
      ),
    );
  }
}
