import 'package:flutter/material.dart';

//using this class to supply the demo items details for the carousel
// slides later on i will replace this class with  api's

class DemoItems {
  List<Map<String, dynamic>> itemDetails = [
    {
      "title": "item 1",
      "description": "description 1",
      "color": Colors.red,
    },
    {
      "title": "item 2",
      "description": "description 2",
      "color": Colors.blue,
    },
    {
      "title": "item 3",
      "description": "description 3",
      "color": Colors.green,
    },
  ];
}
