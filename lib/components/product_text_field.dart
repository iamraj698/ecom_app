import 'dart:io';

import 'package:ecom_app/components/my_text.dart';
import 'package:ecom_app/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProductTextField extends StatefulWidget {
  ProductTextField(
      {super.key,
      required this.title,
      this.inputType = TextInputType.text,
      this.inputDigit = false,
      this.maxLines = 1,
      this.controller});
  String title;
  TextInputType inputType;
  bool inputDigit;
  int maxLines;
  TextEditingController? controller;

  @override
  State<ProductTextField> createState() => _ProductTextFieldState();
}

class _ProductTextFieldState extends State<ProductTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText(
          title: widget.title,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        SizedBox(height: height(8)),
        Container(
          padding: EdgeInsets.only(
            left: width(7),
            right: width(7),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(width(10)),
            color: Colors.grey[100],
          ),
          child: TextField(
            controller: widget.controller,
            maxLines: widget.maxLines,
            keyboardType: widget.inputType,
            inputFormatters: widget.inputDigit
                ? [FilteringTextInputFormatter.digitsOnly]
                : [],
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: height(15)),
            decoration: InputDecoration(
                hintText: widget.title,
                hintStyle: TextStyle(
                    fontWeight: FontWeight.w500, fontSize: height(15)),
                contentPadding: EdgeInsets.only(left: 0),
                border: OutlineInputBorder(borderSide: BorderSide.none)),
          ),
        ),
      ],
    );
  }
}
