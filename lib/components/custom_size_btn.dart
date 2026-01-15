import 'package:ecom_app/components/my_text.dart';
import 'package:ecom_app/utils/custom_styles.dart';
import 'package:ecom_app/utils/size_config.dart';
import 'package:flutter/material.dart';

class CustomSizeBtn extends StatefulWidget {
  const CustomSizeBtn(
      {super.key, required this.title, required this.onTap, this.color});
  final String title;
  final VoidCallback onTap;
  final Color? color;

  @override
  State<CustomSizeBtn> createState() => _CustomSizeBtnState();
}

class _CustomSizeBtnState extends State<CustomSizeBtn> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: (widget.color != null) ? widget.color : CustomStyles.sizeBtn, // ✅
      child: InkWell(
        hoverColor: Colors.black,
        onTap: widget.onTap,
        child: Container(
          width: width(60),
          height: height(60),
          // decoration: BoxDecoration(
          //   color: CustomStyles.sizeBtn,
          // ),
          child: Center(
            child: MyText(
              title: widget.title,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
