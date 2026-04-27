// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:ecom_app/models/order_models/address_model.dart';
// import 'package:ecom_app/models/order_models/order_item_model.dart';

// class OrderModel {
//   final AddressModel address;
//   final int finalTotal;
//   final DateTime orderedOn;
//   final String paymentType;
//   final double shippingCost;
//   final String upiId;
//   final List<OrderItemModel> orderList;

//   OrderModel({
//     required this.address,
//     required this.finalTotal,
//     required this.orderedOn,
//     required this.paymentType,
//     required this.shippingCost,
//     required this.upiId,
//     required this.orderList,
//   });

//   factory OrderModel.fromFirestore(DocumentSnapshot doc) {
//     final data = doc.data() as Map<String, dynamic>;

//     return OrderModel(
//       address: AddressModel.fromMap(data['address']),
//       finalTotal: data['finalTotal'] ?? 0,
//       orderedOn: (data['orderedOn'] as Timestamp).toDate(),
//       paymentType: data['paymentType'] ?? '',
//       shippingCost: (data['shippingCost'] ?? 0).toDouble(),
//       upiId: data['upiId'] ?? '',
//       orderList: (data['ordersList'] as List)
//           .map((item) => OrderItemModel.fromMap(item))
//           .toList(),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_app/models/order_models/address_model.dart';
import 'package:ecom_app/models/order_models/order_item_model.dart';

class OrderModel {
  final String orderId; // <-- ADD THIS
  final AddressModel address;
  final int finalTotal;
  final DateTime orderedOn;
  final String paymentType;
  final double shippingCost;
  final String upiId;
  final List<OrderItemModel> orderList;

  OrderModel({
    required this.orderId,
    required this.address,
    required this.finalTotal,
    required this.orderedOn,
    required this.paymentType,
    required this.shippingCost,
    required this.upiId,
    required this.orderList,
  });

  factory OrderModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return OrderModel(
      orderId: doc.id, // <-- GET DOCUMENT ID HERE
      address: AddressModel.fromMap(data['address']),
      finalTotal: data['finalTotal'] ?? 0,
      orderedOn: (data['orderedOn'] as Timestamp).toDate(),
      paymentType: data['paymentType'] ?? '',
      shippingCost: (data['shippingCost'] ?? 0).toDouble(),
      upiId: data['upiId'] ?? '',
      orderList: (data['ordersList'] as List)
          .map((item) => OrderItemModel.fromMap(item))
          .toList(),
    );
  }
}
