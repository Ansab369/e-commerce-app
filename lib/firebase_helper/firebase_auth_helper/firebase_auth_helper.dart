// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/constants/constants.dart';
import 'package:flutter_ecommerce/models/user_model/user_model.dart';

class FirebaseAuthHelper {
  static FirebaseAuthHelper instance = FirebaseAuthHelper();
  final FirebaseAuth _auth = FirebaseAuth.instance; //created instance
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Stream<User?> get getAuthChange => _auth.authStateChanges();

  Future<bool> login(
      String emailAddress, String password, BuildContext context) async {
    try {
      showLoaderDialogue(context); // loading
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailAddress,
          password: password); //LogIn with email and password
      Navigator.of(context).pop();
      return true;
    } on FirebaseAuthException catch (error) {
      Navigator.of(context).pop();
      showMessage(error.code.toString());
      return false;
    }
  }

  Future<bool> signUp(
      {required String name,
      required String emailAddress,
      required String password,
      required BuildContext context}) async {
    try {
      showLoaderDialogue(context); // loading
      UserCredential? userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailAddress,
              password: password); //create account with email and password
      final UserModel userModel = UserModel(
        id: userCredential.user!.uid,
        name: name,
        email: emailAddress,
        image: null,
      );

      await _firebaseFirestore
          .collection('users')
          .doc(userModel.id)
          .set(userModel.toJson());

      Navigator.of(context).pop();
      return true;
    } on FirebaseAuthException catch (error) {
      Navigator.of(context).pop();
      showMessage(error.code.toString());
      return false;
    }
    //!
  }

  void logOut() {
    _auth.signOut();
  }
}
