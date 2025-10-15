import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  FirebaseAuth _auth = FirebaseAuth.instance;

//Firebase Sign Up method
  Future signUp(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user?.email;
    } on FirebaseAuthException catch (ex) {
      print("Firebase Specific Exception ${ex.toString()}");
      return ex;
    } catch (e) {
      print("General Exception ${e}");
      return e;
    }
  }

  //Firebase Sign Up method
  Future signOut() async {
    try {
      await _auth.signOut();
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
      return userCredential.user?.email;
    } on FirebaseAuthException catch (ex) {
      print("Firebase Specific Exception ${ex.message}");
      return ex.message;
    } catch (e) {
      print("General Exception ${e}");
      return e;
    }
  }
}
