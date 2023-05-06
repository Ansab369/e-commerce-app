// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

//! to show message like scaffold messanger
void showMessage(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

//!  Loader Dialogue

showLoaderDialogue(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Builder(
      builder: (context) {
        return SizedBox(
          width: 100,
          child: Column(children: [
            CircularProgressIndicator(
              color: Colors.red,
            ),
            SizedBox(height: 18),
            Container(
              margin: EdgeInsets.only(left: 7),
              child: Text('Loading...'),
            )
          ]),
        );
      },
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

//! error message
String getMessageFromErrorCode(String errorCode) {
  switch (errorCode) {
    case "ERROR_EMAIL_ALREADY_IN_USE":
      return "Email already used. Go to login page.";
    case "account-exists-with-different-credential":
      return "Email already used. Go to login page.";
    case "email-already-in-use":
      return "Email already used. Go to login page.";
    case "ERROR_WRONG_PASSWORD":
    case "wrong-password":
      return "Wrong Password ";
    case "ERROR_USER_NOT_FOUND":
      return "No user found with this email.";
    case "user-not-found":
      return "No user found with this email.";
    case "ERROR_USER_DISABLED":
      return "User disabled.";
    case "user-disabled":
      return "User disabled.";
    case "ERROR_TOO_MANY_REQUESTS":
      return "Too many requests to log into this account.";
    case "operation-not-allowed":
      return "Too many requests to log into this account.";
    case "ERROR_OPERATION_NOT_ALLOWED":
      return "Too many requests to log into this account.";
    case "ERROR_INVALID_EMAIL":
      return "Email address is invalid.";
    case "invalid-email":
      return "Email address is invalid.";
    default:
      return "Login failed. Please try again.";
  }
}
