import 'dart:io';
import 'package:ecom_app/utils/size_config.dart';
import 'package:flutter/material.dart';

class CustomImage extends StatefulWidget {
  CustomImage({super.key, required this.image});
  File image;

  @override
  State<CustomImage> createState() => _CustomImageState();
}

class _CustomImageState extends State<CustomImage> {
  @override
  Widget build(BuildContext context) {
    return Image.file(
      widget.image,
      width: width(200),
      height: height(100),
    );
  }
}
