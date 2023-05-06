import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/constants/constants.dart';

class FirebaseAuthHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance; //created instance
  Stream<User?> get getAuthChange => _auth.authStateChanges();

  Future<bool> login(
      String emailAddress, String password, BuildContext context) async {
    try {
      showLoaderDialogue(context); // loading
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailAddress,
          password: password); //sign in with email and password
      Navigator.of(context).pop();

      // Navigator.of(context)
      //     .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
      return true;
    } on FirebaseAuthException catch (e) {
      // if (e.code == 'user-not-found') {
      //   print('No user found for that email.');
      // } else if (e.code == 'wrong-password') {
      //   print('Wrong password provided for that user.');
      // }
      return false;
    }
  }
}
