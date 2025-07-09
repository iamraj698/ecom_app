import 'package:ecom_app/components/my_text.dart';
import 'package:ecom_app/utils/size_config.dart';
import 'package:flutter/material.dart';

class BrandComponent extends StatelessWidget {
  const BrandComponent(
      {super.key, required this.imagePath, required this.title});
  final String imagePath;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: width(115),
          height: height(50),
          decoration: BoxDecoration(
              color: Color(
                0xffF5F6FA,
              ),
              borderRadius: BorderRadius.circular(width(15))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(imagePath),
              MyText(
                title: title,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              )
            ],
            
          ),
        ),
        SizedBox(width:width(10),)
      ],
    );
  }
}
