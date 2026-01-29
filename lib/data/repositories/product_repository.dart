import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_app/data/exceptions/app_exception.dart';
import 'package:ecom_app/models/product_model/product_model.dart';
import 'package:ecom_app/models/review_model/review_model.dart';
import 'package:ecom_app/utils/app_constants.dart';
import 'package:ecom_app/utils/fetch_firebase_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProductRepository {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

//Firebase adding product to the collection
  Future addProduct(
    String title,
    String subTitle,
    String? brand,
    int price,
    String description,
    int smQty,
    int mdQty,
    int lgQty,
    int xlQty,
    String img1,
    String img2,
    String img3,
    String img4,
    String img5,
  ) async {
    try {
      print("inside prod repo");
      final userdetail = await fetchFirebaseUser();
      final docRef = await _firestore.collection('products').add({
        "seller_id": userdetail!.uid.toString(),
        "prouctTitle": title,
        "subTitle": subTitle,
        "brand": brand,
        "price": price,
        "description": description,
        "smQty": smQty,
        "mdQty": mdQty,
        "lgQty": lgQty,
        "xlQty": xlQty,
        "img1": img1,
        "img2": img2,
        "img3": img3,
        "img4": img4,
        "img5": img5,
      });
      print("product added successfully ${docRef.id}");

      return "success";
      // print(docRef.id);
    } on FirebaseException catch (ex) {
      print("Firebase Specific Exception ${ex.toString()}");
      return ex.toString();
    } catch (e) {
      print("General Exception ${e}");
      return e.toString();
    }
  }

//fetch all the products

  Future fetchProducts() async {
    try {
      final res = await _firestore.collection("products").get();
      // print(" the response is ");

      // for (QueryDocumentSnapshot doc in res.docs) {
      //   final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      //   // print("ID: ${doc.id}");
      //   // print("Title: ${data['prouctTitle']}");
      //   // print("Price: ${data['price']}");
      //   // print("Description: ${data['description']}");
      //   // print("Image Base64 length: ${data['img4']?.length}");
      //   return data;
      // }
      return res;
    } on FirebaseException catch (ex) {
      print(
          "Firebase Specific Exception in fetching the products  ${ex.toString()}");
      return ex.toString();
    } catch (e) {
      print("error ${e.toString()}");
    }
  }

  // fetch single product

  Future fetchSingleProduct({required String product_id}) async {
    // print("here_______________________________________");
    try {
      final res = await _firestore.collection("products").doc(product_id).get();
      return res;
    } on FirebaseException catch (ex) {
      print(
          "Firebase Specific Exception in fetching the products  ${ex.toString()}");
      return ex.toString();
    } catch (e) {
      print("error ${e.toString()}");
    }
  }

  Future productDetailCartIsExist(
      {required String product_id, required String qtyType}) async {
    // print("here_______________________________________");
    try {
      final res = await _firestore
          .collection("Users")
          .doc(AppConstants.user!.uid)
          .collection("cart")
          .doc(product_id + "_" + qtyType)
          .get();

      if (res.exists) {
        print("record exist send true");
        return true;
      } else {
        print("record does not exisits send false");
        return false;
      }

      // return res;
    } on FirebaseException catch (ex) {
      print(
          "Firebase Specific Exception in fetching the products  ${ex.toString()}");
      return ex.toString();
    } catch (e) {
      print("error ${e.toString()}");
    }
  }

  //product review
  Future<String?> addReview(
      String review, String productId, String timeStamp, String rating) async {
    final currentUserUId = AppConstants.user!.uid;
    final currentUserName = AppConstants.userDetails["userName"];
    final currentUserEmail = AppConstants.user!.email;

    try {
      final response = await _firestore
          .collection("reviews")
          .doc(productId)
          .collection("allReviews")
          .add({
        "rating": rating,
        "review": review,
        "userName": currentUserName,
        "userId": currentUserUId,
        "userEmail": currentUserEmail,
        "addedOn": timeStamp
      });

      print("review added successfully");

      return "success";
    } on FirebaseException catch (ex) {
      print(
          "Firebase Specific Exception in fetching the products  ${ex.toString()}");
      return ex.toString();
    } catch (e) {
      print("error ${e.toString()}");
      return e.toString();
    }
  }

  // Stream fetchAllReviews({required String productId}) async* {
  //   print("here____________________");
  //   final snapShot = _firestore
  //       .collection("reviews")
  //       .doc(productId)
  //       .collection("allReviews")
  //       .snapshots();
  //   print("the snapshot is ${snapShot}");

  // }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchAllReviews({
    required String productId,
  }) {
    print("here_____________________________");
    final stream = _firestore
        .collection("reviews")
        .doc(productId)
        .collection("allReviews")
        .orderBy("addedOn", descending: true)
        .snapshots();
    print("snapShot");
    // print(snapShot);

    // stream.listen((snapshot) {
    //   print("Documents count: ${snapshot.docs.length}");
    //   for (var doc in snapshot.docs) {
    //     print("Doc ID: ${doc.id}");
    //     print("Data: ${doc.data()}");
    //   }
    // });

    return stream;
  }

  // delete review
  Future<String?> deleteReview({
    required String reviewID,
    required String productId,
  }) async {
    try {
      final response = await _firestore
          .collection("reviews")
          .doc(productId)
          .collection("allReviews")
          .doc(reviewID)
          .delete();

      print("review added successfully");

      return "success";
    } on FirebaseException catch (ex) {
      print(
          "Firebase Specific Exception in fetching the products  ${ex.toString()}");
      return ex.toString();
    } catch (e) {
      print("error ${e.toString()}");
      return e.toString();
    }
  }

  Future fetchLatestSingleReview({required String productID}) async {
    final response = await _firestore
        .collection("reviews")
        .doc(productID)
        .collection("allReviews")
        .orderBy("addedOn", descending: true)
        .limit(1)
        .get();

    if (response.docs.isEmpty) {
      return null;
    }

    return ReviewModel.fromDocumentSnapshot(response.docs.first);
    // print("printing from the repo");
    // for (var res in response.docs) {
    //   print(res.data());
    // }
  }

  // Add to cart

  Future addToCart({
    required String productId,
    required String title,
    required int priceAtTime,
    required String createdAt,
    required int quantity,
    required String banner_image,
    required String qtyType,
  }) async {
    // final response = _firestore.collection(AppConstants.user!.uid!).add({});

    final productRef = _firestore.collection("products").doc(productId);
    final cartRef = _firestore
        .collection('Users')
        .doc(AppConstants.user!.uid)
        .collection("cart")
        .doc(productId + "_" + qtyType);

    try {
      await _firestore.runTransaction(
        (transaction) async {
          final productSnapshot = await transaction.get(productRef);
          if (!productSnapshot.exists) {
            throw NotFoundException(message: "product does not exist");
          }
          final int currentStock = productSnapshot.get(qtyType);
          final int quantity_limit = 4;

          if (currentStock < quantity) {
            throw Exception("Out of Stock");
          }

          final cartSnapshot = await transaction.get(cartRef);

          // if (quantity > 4) {
          //   throw Exception("Onnly 4 quantity is allowed");
          // }

          if (!cartSnapshot.exists) {
            transaction.set(cartRef, {
              "title": title,
              "image": banner_image,
              "price": priceAtTime,
              "quantity": quantity,
              "qtyType": qtyType,
              "createdAt": createdAt,
            });
          } else {
            final type = cartSnapshot.get("qtyType");
            if (type == qtyType) {
              int cartExistingQty = cartSnapshot.get("quantity");
              int newQuantity = cartExistingQty + quantity;
              if (newQuantity > 4) {
                throw LimitExcedes(
                    message: "Only 4 quantity are allowed in the cart");
              }
              transaction.update(cartRef, {"quantity": newQuantity});
            } else {
              // transaction.update(cartRef, {
              //   qtyType: quantity,
              // });
              transaction.set(cartRef, {
                "title": title,
                "image": banner_image,
                "price": priceAtTime,
                "quantity": quantity,
                "qtyType": qtyType,
                "createdAt": createdAt,
              });
            }
          }
          // transaction.update(productRef, {qtyType: currentStock - quantity});
        },
      );
      return "success";
    } on LimitExcedes catch (e) {
      print("limit excedes exception");
      return e.message;
    } catch (e) {
      print("error in updating the cart ${e}");
      return e.toString();
    }
  }

  // fetch cart repo stream
  Stream fetchCartItems() {
    final userId = AppConstants.user!.uid;

    final stream = _firestore
        .collection("Users")
        .doc(userId)
        .collection("cart")
        .snapshots();
    return stream;
  }

  Future deleteCartItem({required String cartItemId}) async {
    final userId = AppConstants.user!.uid;
    try {
      final response = await _firestore
          .collection("Users")
          .doc(userId)
          .collection("cart")
          .doc(cartItemId)
          .delete();

      print("cart item deleted successfully");

      return "success";
    } on FirebaseException catch (ex) {
      print(
          "Firebase Specific Exception in fetching the products  ${ex.toString()}");
      return ex.toString();
    } catch (e) {
      print("error ${e.toString()}");
      return e.toString();
    }
  }

  // increment cart item

  Future incrementCartItem({required String cartItemId}) async {
    final userId = AppConstants.user!.uid;
    final cartSnapshotRef = _firestore
        .collection("Users")
        .doc(userId)
        .collection("cart")
        .doc(cartItemId);

    try {
      final result = await _firestore.runTransaction(
        (transaction) async {
          final cartSnapshot = await transaction.get(cartSnapshotRef);

          final quantity = cartSnapshot.get("quantity");
          if (quantity < 4) {
            final int newQuantity = quantity + 1;
            transaction.update(cartSnapshotRef, {"quantity": newQuantity});
            print("successfully incremented");
            return "success";
          } else {
            throw LimitExcedes(
                message: "Only 4 quantity is allowed to add in the cart");
          }
        },
      );
      return "success";
    } on FirebaseException catch (e) {
      print("error");
    } on LimitExcedes catch (e) {
      print(e.message);
      return e.message;
    } catch (e) {
      print("error in incrementing");
      print("error" + e.toString());
      return e.toString();
    }
  }

// decrement cart item
  Future decrementCartItem({required String cartItemId}) async {
    final userId = AppConstants.user!.uid;
    final cartSnapshotRef = _firestore
        .collection("Users")
        .doc(userId)
        .collection("cart")
        .doc(cartItemId);

    try {
      final result = await _firestore.runTransaction(
        (transaction) async {
          final cartSnapshot = await transaction.get(cartSnapshotRef);

          if (!cartSnapshot.exists) {
            throw Exception("Cart item does not exist");
          }
          final quantity = cartSnapshot.get("quantity");

          if (quantity != null) {
            if (quantity > 1) {
              final int newQuantity = quantity - 1;
              transaction.update(cartSnapshotRef, {"quantity": newQuantity});
              print("successfully Decremented");
              return "success";
            } else if (quantity == 1) {
              transaction.delete(cartSnapshotRef);
              print("product completly removed from the cart");
              return "success";
            } else {
              // throw LimitExcedes(
              //     message: "Only 4 quantity is allowed to add in the cart");
              throw Exception("Unable to delete the product");
            }
          }
        },
      );
      return result;
    } on FirebaseException catch (e) {
      print("error");
    } on LimitExcedes catch (e) {
      print(e.message);
      return e.message;
    } catch (e) {
      print("error in incrementing");
      print("error" + e.toString());
      return e.toString();
    }
  }

  //   try {
  //     final response = await _firestore
  //         .collection("Users")
  //         .doc(userId)
  //         .collection("cart")
  //         .doc(cartItemId)
  //         .update({"quantity":});

  //     print("cart item deleted successfully");

  //     return "success";
  //   } on FirebaseException catch (ex) {
  //     print(
  //         "Firebase Specific Exception in fetching the products  ${ex.toString()}");
  //     return ex.toString();
  //   } catch (e) {
  //     print("error ${e.toString()}");
  //     return e.toString();
  //   }
  // }
}
