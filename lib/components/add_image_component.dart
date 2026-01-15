import 'package:ecom_app/components/my_text.dart';
import 'package:ecom_app/utils/custom_styles.dart';
import 'package:ecom_app/utils/size_config.dart';
import 'package:flutter/material.dart';

class AddImageComponent extends StatefulWidget {
  const AddImageComponent({super.key});

  @override
  State<AddImageComponent> createState() => _AddImageComponentState();
}

class _AddImageComponentState extends State<AddImageComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: width(200),
        height: height(100),
        decoration: BoxDecoration(color: CustomStyles.lightBlueColor),
        child: Center(child: MyText(title: "+", fontSize: 40)));
  }
}
