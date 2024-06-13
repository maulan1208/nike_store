// import 'dart:js_interop_unsafe';

import 'package:firebase_auth/firebase_auth.dart';
// import 'package:nike_shop/screens/cart.dart';
// import 'package:firebase_core/firebase_core.dart';

class AuthMethods{
  final FirebaseAuth auth = FirebaseAuth.instance;

  getCurrentUser() async {
    return await auth.currentUser;
  }

  Future SignOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future deleteUser() async {
    User? user = await FirebaseAuth.instance.currentUser;
    user?.delete();
  }
}