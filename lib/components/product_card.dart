import 'dart:convert';

import 'package:ecom_app/components/my_text.dart';
import 'package:ecom_app/utils/size_config.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  ProductCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.price,
    required this.isWishlisted,
    required this.onWishlistToggle,
    required this.onCardTap,
  });
  final String imagePath;
  final String title;
  final String price;
  final bool isWishlisted;
  VoidCallback onWishlistToggle;
  VoidCallback onCardTap;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    print(widget.isWishlisted);
    return InkWell(
      onTap: widget.onCardTap,
      child: SizedBox(
        width: width(167),
        height: height(270),
        child: Card(
          color: Color(
            0xffF5F6FA,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: width(10)),
                    child: GestureDetector(
                      onTap: widget.onWishlistToggle,
                      child: Icon(
                        widget.isWishlisted
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: widget.isWishlisted ? Colors.red : Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              Center(
                // child: Image.asset(
                //   widget.imagePath,
                //   height: height(167),
                // ),
                child: Image.memory(
                  base64Decode(
                    widget.imagePath,
                  ),
                  gaplessPlayback: true,
                  height: height(167),
                ),
              ),

              SizedBox(
                height: height(7),
              ),
              // title + price

              Padding(
                padding: EdgeInsets.only(left: width(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width(117),
                      // height: height(30),
                      child: Text(
                        widget.title,
                        maxLines: 2,
                        style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: height(11),
                            fontWeight: FontWeight.w600),
                      ),
                    ),

                    // price
                    MyText(
                      title: widget.price,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
