import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom_app/utils/app_constants.dart';
import 'package:ecom_app/utils/fetch_firebase_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

//Firebase Sign Up method
  Future signUp(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      await createUser(
          uid: userCredential.user!.uid, email: userCredential.user!.email!);

      return userCredential.user?.email;
    } on FirebaseAuthException catch (ex) {
      print("Firebase Specific Exception ${ex.toString()}");
      return ex;
    } catch (e) {
      print("General Exception ${e}");
      return e;
    }
  }

  // create a user table if not exists

  Future createUser({required String uid, required String email}) async {
    try {
      await _firestore
          .collection('Users')
          .doc(uid)
          .set({"useId": uid, "userName": "", "email": email, "dob": ""});
    } on FirebaseAuthException catch (ex) {
      print("Firebase Specific Exception ${ex.toString()}");
      return ex;
    } catch (e) {
      print("General Exception ${e}");
      return e;
    }
  }

  //Firebase Sign out method
  Future signOut() async {
    try {
      await _auth.signOut();
      AppConstants.user = null;
      AppConstants.userDetails = {};
    } on FirebaseAuthException catch (ex) {
      print("Firebase Specific Exception ${ex.toString()}");
      return ex;
    } catch (e) {
      print("General Exception ${e}");
      return e;
    }
  }

  //Firebase Sign Up method
  Future signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      // fetch the complete user details and assign it to the userdetail constant
      final userdetails = await _firestore
          .collection('Users')
          .doc(userCredential.user?.uid)
          .get();

      // AppConstants.userDetails = userdetails.data() as Map<String, dynamic>;
      await fetchUserProfile();

      print("the user details are ${userdetails.data()} ");

      return userCredential.user?.email;
    } on FirebaseAuthException catch (ex) {
      print("Firebase Specific Exception ${ex.message}");
      return ex.message;
    } catch (e) {
      print("General Exception ${e}");
      return e;
    }
  }

  // fetch user profile

  Future fetchUserProfile() async {
    try {
      final user = await fetchFirebaseUser();
      AppConstants.user = user;
      final uid = user!.uid;
      final email = user!.email;
      var docRef = _firestore.collection("Users").doc(uid);
      var response = await docRef.get();
      var userData = response.data();

      if (userData != null) {
        AppConstants.userDetails = userData as Map<String, dynamic>;
      } else {
        await createUser(uid: uid, email: email!);
        final newSnapshot = await docRef.get();
        final newSnapshotData = newSnapshot.data();
        AppConstants.userDetails = newSnapshotData as Map<String, dynamic>;
        return newSnapshotData;
      }

      return userData;
    } on FirebaseAuthException catch (ex) {
      print("Firebase Specific Exception ${ex.message}");
      return ex.message;
    } catch (e) {
      print("General Exception ${e}");
      return e;
    }
  }

  // update user profile

  Future updateUserProfile(
      {required String name,
      required String email,
      required String uid,
      required String dob}) async {
    try {
      var response = await _firestore
          .collection("Users")
          .doc(uid)
          .update({"userName": name, "email": email, "dob": dob});
      final user = fetchUserProfile();
      if (user == null) {
        await _firestore
            .collection('Users')
            .doc(uid)
            .set({"useId": uid, "userName": name, "email": email, "dob": dob});
      }
      // print(response);
      return "success";
    } on FirebaseAuthException catch (ex) {
      print("Firebase Specific Exception ${ex.message}");
      return ex.message;
    } catch (e) {
      print("General Exception ${e}");
      return e;
    }
  }
}
