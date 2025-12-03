import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_app/utils/fetch_firebase_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProductRepository {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

//Firebase adding product to the collection
  Future addProduct(
    String title,
    String subTitle,
    String? brand,
    String price,
    String description,
    String smQty,
    String mdQty,
    String lgQty,
    String xlQty,
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

  // //Firebase Sign Up method
  // Future signOut() async {
  //   try {
  //     await _auth.signOut();
  //   } on FirebaseAuthException catch (ex) {
  //     print("Firebase Specific Exception ${ex.toString()}");
  //     return ex;
  //   } catch (e) {
  //     print("General Exception ${e}");
  //     return e;
  //   }
  // }

  //Firebase Sign Up method
  // Future signIn(String email, String password) async {
  //   try {
  //     UserCredential userCredential = await _auth.signInWithEmailAndPassword(
  //         email: email, password: password);
  //     return userCredential.user?.email;
  //   } on FirebaseAuthException catch (ex) {
  //     print("Firebase Specific Exception ${ex.message}");
  //     return ex.message;
  //   } catch (e) {
  //     print("General Exception ${e}");
  //     return e;
  //   }
  // }
}
