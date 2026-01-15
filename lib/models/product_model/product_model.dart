import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String id; // Firestore document ID
  final String brand;
  final String description;
  final String img1;
  final String img2;
  final String img3;
  final String img4;
  final String img5;
  final String lgQty;
  final String mdQty;
  final String smQty;
  final String xlQty;
  final String price;
  final String productTitle;
  final String subTitle;
  final String sellerId;

  ProductModel({
    required this.id,
    required this.brand,
    required this.description,
    required this.img1,
    required this.img2,
    required this.img3,
    required this.img4,
    required this.img5,
    required this.lgQty,
    required this.mdQty,
    required this.smQty,
    required this.xlQty,
    required this.price,
    required this.productTitle,
    required this.subTitle,
    required this.sellerId,
  });

  /// 🔹 Create model from Firestore document
  factory ProductModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return ProductModel(
      id: doc.id,
      brand: data['brand'] ?? '',
      description: data['description'] ?? '',
      img1: data['img1'] ?? '',
      img2: data['img2'] ?? '',
      img3: data['img3'] ?? '',
      img4: data['img4'] ?? '',
      img5: data['img5'] ?? '',
      lgQty: data['lgQty'] ?? '0',
      mdQty: data['mdQty'] ?? '0',
      smQty: data['smQty'] ?? '0',
      xlQty: data['xlQty'] ?? '0',
      price: data['price'] ?? '0',
      productTitle: data['prouctTitle'] ?? '', // ⚠ typo handled
      subTitle: data['subTitle'] ?? '',
      sellerId: data['seller_id'] ?? '',
    );
  }

  /// 🔹 Convert model to Map (for upload / update)
  Map<String, dynamic> toMap() {
    return {
      'brand': brand,
      'description': description,
      'img1': img1,
      'img2': img2,
      'img3': img3,
      'img4': img4,
      'img5': img5,
      'lgQty': lgQty,
      'mdQty': mdQty,
      'smQty': smQty,
      'xlQty': xlQty,
      'price': price,
      'prouctTitle': productTitle,
      'subTitle': subTitle,
      'seller_id': sellerId,
    };
  }
}
