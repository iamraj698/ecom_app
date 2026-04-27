import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_app/models/cart_item_model/cart_item_model.dart';
import 'package:ecom_app/models/order_models/order_item_model.dart';
import 'package:ecom_app/utils/app_constants.dart';

class OrdersRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Future placeOrder({
  //   required int finalTotal,
  //   required List<CartItemModel>? cartItems,
  //   required Map address,
  //   required double shippingCost,
  //   required DateTime orderedOn,
  //   required String orderType,
  //   String? upiId,
  //   int? cardNumber,
  //   int? validThu,
  //   int? cvv,
  // }) async {
  //   try {
  //     final userId = AppConstants.user!.uid;

  //     final orderRepoRef =
  //         _firestore.collection("Users").doc(userId).collection("orders");

  //     final productRef = _firestore.collection("products");

  //     final sellerOrderRef =
  //         _firestore.collection("Seller").doc(userId).collection("orders");

  //     final cartRef =
  //         _firestore.collection("Users").doc(userId).collection("cart");

  //     await _firestore.runTransaction((transaction) async {
  //       /// Order document
  //       final orderDoc = orderRepoRef.doc();
  //       final sellerDoc = sellerOrderRef.doc();

  //       /// READ cart
  //       final cartSnapshot = await cartRef.get();
  //       // final Map<String, List<CartItemModel>> items={};
  //       List<Map<String, dynamic>> products = [];

  //       /// READ product documents first (required by Firestore)
  //       for (var item in cartItems!) {
  //         /// Extract productId from "productId_qtyType"
  //         products.add({
  //           "productId": item.id.split("_")[0],
  //           "title": item.title,
  //           "price": item.price,
  //           "quantityType": item.qtyType,
  //           "quantity": item.quantity,
  //         });

  //         final productId = item.id.split("_")[0];

  //         final productDoc = productRef.doc(productId);

  //         final snapshot = await transaction.get(productDoc);

  //         if (!snapshot.exists) {
  //           throw Exception("Product not found: $productId");
  //         }
  //       }

  //       Map<String, dynamic> orderData = {
  //         "finalTotal": finalTotal,
  //         "address": address,
  //         "ordersList": products,
  //         "shippingCost": shippingCost,
  //         "orderedOn": orderedOn,
  //         "paymentType": orderType,
  //       };

  //       print(orderData);

  //       /// Payment details
  //       if (orderType == "upi") {
  //         orderData["upiId"] = upiId;
  //       }

  //       if (orderType == "cod") {
  //         orderData["cod"] = true;
  //       }

  //       /// CREATE ORDER
  //       transaction.set(orderDoc, orderData);
  //       transaction.set(sellerDoc, orderData);

  //       /// DELETE CART ITEMS
  //       for (var doc in cartSnapshot.docs) {
  //         transaction.delete(doc.reference);
  //       }

  //       /// UPDATE PRODUCT STOCK
  //       for (var item in cartItems) {
  //         final productId = item.id.split("_")[0];
  //         final productDoc = productRef.doc(productId);

  //         transaction.update(productDoc, {
  //           item.qtyType: FieldValue.increment(-item.quantity),
  //         });
  //       }
  //     });

  //     return "success";
  //   } catch (e) {
  //     print("Order Error: $e");
  //     return e.toString();
  //   }
  // }

  Future placeOrder({
    required int finalTotal,
    required List<CartItemModel>? cartItems,
    required Map address,
    required double shippingCost,
    required DateTime orderedOn,
    required String orderType,
    String? upiId,
    int? cardNumber,
    int? validThu,
    int? cvv,
  }) async {
    try {
      final userId = AppConstants.user!.uid;

      final orderRepoRef =
          _firestore.collection("Users").doc(userId).collection("orders");

      final productRef = _firestore.collection("products");

      final cartRef =
          _firestore.collection("Users").doc(userId).collection("cart");

      await _firestore.runTransaction((transaction) async {
        /// Buyer Order Doc
        final orderDoc = orderRepoRef.doc();

        /// Read cart
        final cartSnapshot = await cartRef.get();

        List<Map<String, dynamic>> products = [];

        /// Map for grouping seller items
        Map<String, List<Map<String, dynamic>>> sellerItems = {};

        /// READ PRODUCTS
        for (var item in cartItems!) {
          final productId = item.id.split("_")[0];

          final productDoc = productRef.doc(productId);

          final snapshot = await transaction.get(productDoc);

          if (!snapshot.exists) {
            throw Exception("Product not found: $productId");
          }

          /// product data
          final productData = {
            "productId": productId,
            "title": item.title,
            "price": item.price,
            "quantityType": item.qtyType,
            "quantity": item.quantity,
            "sellerId": item.sellerId,
            "quantityType": item.qtyType
          };

          products.add(productData);

          /// GROUP BY SELLER
          if (!sellerItems.containsKey(item.sellerId)) {
            sellerItems[item.sellerId] = [];
          }

          sellerItems[item.sellerId]!.add(productData);
        }

        Map<String, dynamic> orderData = {
          "buyerId": userId,
          "finalTotal": finalTotal,
          "address": address,
          "ordersList": products,
          "shippingCost": shippingCost,
          "orderedOn": orderedOn,
          "paymentType": orderType,
        };

        if (orderType == "upi") {
          orderData["upiId"] = upiId;
        }

        if (orderType == "cod") {
          orderData["cod"] = true;
        }

        /// BUYER ORDER
        transaction.set(orderDoc, orderData);

        /// SELLER ORDERS
        sellerItems.forEach((sellerId, sellerProducts) {
          final sellerOrderRef = _firestore
              .collection("Sellers")
              .doc(sellerId)
              .collection("orders")
              .doc(orderDoc.id);

          transaction.set(sellerOrderRef, {
            "buyerId": userId,
            "address": address,
            "ordersList": sellerProducts,
            "shippingCost": shippingCost,
            "orderedOn": orderedOn,
            "paymentType": orderType,
            "status": "placed",
          });
        });

        /// DELETE CART
        for (var doc in cartSnapshot.docs) {
          transaction.delete(doc.reference);
        }

        /// UPDATE STOCK
        for (var item in cartItems) {
          final productId = item.id.split("_")[0];

          final productDoc = productRef.doc(productId);

          transaction.update(productDoc, {
            item.qtyType: FieldValue.increment(-item.quantity),
          });
        }
      });

      return "success";
    } catch (e) {
      print("Order Error: $e");
      return e.toString();
    }
  }

  Future<dynamic> getAllOrders() async {
    try {
      final userId = AppConstants.user!.uid;
      final response = await _firestore
          .collection("Users")
          .doc(userId)
          .collection("orders")
          .get();

      print(response.docs);
      return response;
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }

  // cancel order

  Future cancelOrder({
    required String orderId,
    required List<OrderItemModel> orderItems,
  }) async {
    try {
      final userId = AppConstants.user!.uid;

      final orderRef = _firestore
          .collection("Users")
          .doc(userId)
          .collection("orders")
          .doc(orderId);

      final productRef = _firestore.collection("products");

      final response = await _firestore.runTransaction((transaction) async {
        /// DELETE BUYER ORDER
        transaction.delete(orderRef);

        /// GROUP ITEMS BY SELLER
        Map<String, List<OrderItemModel>> sellerItems = {};

        for (var item in orderItems) {
          if (!sellerItems.containsKey(item.sellerId)) {
            sellerItems[item.sellerId] = [];
          }
          sellerItems[item.sellerId]!.add(item);
        }

        /// DELETE SELLER ORDERS
        sellerItems.forEach((sellerId, items) {
          final sellerOrderRef = _firestore
              .collection("Sellers")
              .doc(sellerId)
              .collection("orders")
              .doc(orderId);

          transaction.delete(sellerOrderRef);
        });

        /// RESTORE STOCK
        for (var item in orderItems) {
          final productDoc = productRef.doc(item.productId);

          transaction.update(productDoc, {
            item.quantityType: FieldValue.increment(item.quantity),
          });
        }
      });
      print("here__________________________");
      print(response);

      return "cancelled";
    } catch (e) {
      print("Cancel Error: $e");
      return e.toString();
    }
  }
}
