import 'package:flutter/material.dart';

//using this class to supply the demo items details for the carousel
// slides later on i will replace this class with  api's

class DemoWishList {
  static Map<String, dynamic> productDetails =
   {
    "total-products":3,
    "products": [
      {
        "title": "Nike Sportswear Club Fleece",
        "image": "./assets/images/products/product_1.png",
        "price": "\$99"
      },
      {
        "title": "Trail Running Jacket Nike Windrunner",
        "image": "./assets/images/products/product_2.png",
        "price": "\$99"
      },
      {
        "title": "Training Top Nike Sport Clash",
        "image": "./assets/images/products/product_3.png",
        "price": "\$99"
      },
    ]
  };
}
