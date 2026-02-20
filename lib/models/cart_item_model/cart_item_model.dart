import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';

class CartItemModel {
  final String id; // document id
  final String title;
  final int price;
  final int quantity;
  // final String image;
  final Uint8List image;
  final String qtyType;
  final DateTime createdAt;

  CartItemModel({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    required this.image,
    required this.qtyType,
    required this.createdAt,
  });

  /// 🔹 From Firestore DocumentSnapshot
  factory CartItemModel.fromDocument(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data()!;

    return CartItemModel(
      id: doc.id,
      title: data['title'] ?? '',
      price: data['price'] ?? 0,
      quantity: data['quantity'] ?? 0,
      image: base64Decode(data['image']),
      qtyType: data['qtyType'] ?? '',
      createdAt: DateTime.parse(data['createdAt']),
    );
  }

  /// 🔹 To Firestore
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'price': price,
      'quantity': quantity,
      'image': image,
      'qtyType': qtyType,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
