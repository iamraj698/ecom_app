import 'package:flutter/material.dart';

class Sliders extends StatelessWidget {
  final String title;
  final String description;
  final Color color;

  Sliders({
    super.key,
    required this.title,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.75,
      height: size.height * 0.3,
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Column(
        children: [
          Icon(
            Icons.slideshow,
            size: size.height*0.1,
          ),
          Text(title),
          SizedBox(
            height: 10,
          ),
          Text(description),
        ],
      ),
    );
  }
}
