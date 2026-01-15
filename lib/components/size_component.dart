import 'package:ecom_app/components/my_text.dart';
import 'package:ecom_app/utils/custom_styles.dart';
import 'package:ecom_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SizeComponent extends StatefulWidget {
  SizeComponent(
      {super.key, required String this.size, required this.controller});
  String size;
  TextEditingController controller;

  @override
  State<SizeComponent> createState() => _SizeComponentState();
}

class _SizeComponentState extends State<SizeComponent> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        MyText(
          title: widget.size,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        SizedBox(
          width: width(10),
        ),
        Container(
            height: height(50),
            width: width(50),
            color: CustomStyles.lightBlueColor,
            child: TextField(
              controller: widget.controller,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
              ),
            ))
      ],
    );
  }
}
