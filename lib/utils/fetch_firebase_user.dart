import 'package:firebase_auth/firebase_auth.dart';

Future<User?> fetchFirebaseUser() async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User? user = await _auth.currentUser;
  // print(user);
  return user;
}
