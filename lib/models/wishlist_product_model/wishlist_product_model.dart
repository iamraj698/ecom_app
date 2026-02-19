import 'package:cloud_firestore/cloud_firestore.dart';

class WishListModel {
  final String bannerImage;
  final int price;
  final String productId;
  final String title;

  WishListModel({
    required this.bannerImage,
    required this.price,
    required this.productId,
    required this.title,
  });

  /// Convert Firestore DocumentSnapshot → Model
  factory WishListModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return WishListModel(
      bannerImage: data['banner_image'] ?? '',
      price: (data['price'] ?? 0),
      productId: data['productId'] ?? doc.id,
      title: data['title'] ?? '',
    );
  }

  /// Convert Model → Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'banner_image': bannerImage,
      'price': price,
      'productId': productId,
      'title': title,
    };
  }
}
