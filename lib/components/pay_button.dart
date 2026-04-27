import 'package:ecom_app/components/my_text.dart';
import 'package:ecom_app/utils/custom_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PayButton extends StatefulWidget {
  PayButton({super.key, required this.title, required this.onTap});
  String title;
  VoidCallback onTap;

  @override
  State<PayButton> createState() => _PayButtonState();
}

class _PayButtonState extends State<PayButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: CupertinoButton(
        child: MyText(
          title: widget.title,
          fontSize: 14,
          color: CustomStyles.textWhite,
        ),
        color: CustomStyles.submit,
        onPressed: widget.onTap,
      ),
    );
  }
}
