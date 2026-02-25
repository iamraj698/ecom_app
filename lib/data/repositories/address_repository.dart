import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_app/utils/app_constants.dart';
import 'package:ecom_app/utils/fetch_firebase_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddressRepository {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

//Firebase Sign Up method
  Future addAddressToFirebase(
      {required String name,
      required int phone,
      required String area,
      required String city,
      required String state,
      required String country,
      required int pincode}) async {
    try {
      final userId = AppConstants.user!.uid;
      final response = await _firestore
          .collection("Users")
          .doc(userId)
          .collection("addresses")
          .add({
        "name": name,
        "phone": phone,
        "area": area,
        "city": city,
        "state": state,
        "country": country,
        "pincode": pincode
      });
      print(response);
      return "success";
    } on FirebaseAuthException catch (ex) {
      print("Firebase Specific Exception ${ex.toString()}");
      return ex.toString();
    } catch (e) {
      print("General Exception ${e}");
      return e.toString();
    }
  }

  Future fetchAllAddresses() async {
    try {
      final userId = AppConstants.user!.uid;
      final response = await _firestore
          .collection("Users")
          .doc(userId)
          .collection("addresses")
          .get();
      print(response);
      return response;
    } on FirebaseAuthException catch (ex) {
      print("Firebase Specific Exception ${ex.toString()}");
      return ex.toString();
    } catch (e) {
      print("General Exception ${e}");
      return e.toString();
    }
  }
}
