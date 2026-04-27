class OrderItemModel {
  final String productId;
  final String productName;
  final int price;
  final int quantity;
  final String sellerId;
  final String quantityType;
  final String image;

  OrderItemModel({
    required this.productId,
    required this.productName,
    required this.price,
    required this.quantity,
    required this.sellerId,
    required this.quantityType,
    required this.image,
  });

  factory OrderItemModel.fromMap(Map<String, dynamic> map) {
    return OrderItemModel(
      productId: map['productId'] ?? '',
      productName: map['title'] ?? 'hh',
      price: map['price'] ?? 0,
      quantity: map['quantity'] ?? 0,
      sellerId: map['sellerId'],
      quantityType: map['quantityType'],
      image: map['image'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'productName': productName,
      'price': price,
      'quantity': quantity,
      'sellerId': sellerId,
      'quantityType': quantityType,
      'image': image,
    };
  }
}
