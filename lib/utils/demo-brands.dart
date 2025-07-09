import 'package:flutter/material.dart';

//using this class to supply the demo items details for the carousel
// slides later on i will replace this class with  api's

class DemoBrands {
  static List<Map<String, dynamic>> brandDetails = [
    {
      "title": "Adidas",
      "image": "./assets/images/brands/Adidas.png",
    },
    {
      "title": "Nike",
      "image": "./assets/images/brands/nike.png",
    },
    {
      "title": "Fila",
      "image": "./assets/images/brands/fila.png",
    },
    {
      "title": "Puma",
      "image": "./assets/images/brands/puma.png",
    },
  ];
}
