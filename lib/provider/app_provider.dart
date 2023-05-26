import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/constants/constants.dart';
import 'package:flutter_ecommerce/firebase_helper/firebase_firestore_helper/firebase_firestore_helper.dart';
import 'package:flutter_ecommerce/firebase_helper/firebase_storage/firebase_storage_helper.dart';
import 'package:flutter_ecommerce/models/product_model/product_model.dart';
import 'package:flutter_ecommerce/models/user_model/user_model.dart';

class AppProvider with ChangeNotifier {
// CART
  List<ProductModel> _cartProductModel = [];
  UserModel? _userModel;

  UserModel? get getUserInformation => _userModel;

  void addCartProduct(ProductModel productModel) {
    _cartProductModel.add(productModel);
    notifyListeners();
  }

  void removeCartProduct(ProductModel productModel) {
    _cartProductModel.remove(productModel);
    notifyListeners();
  }

  List<ProductModel> get getCartProductList => _cartProductModel;

  // FAVORITE
  List<ProductModel> _favoriteProductModel = [];

  void addFavoriteProduct(ProductModel productModel) {
    _favoriteProductModel.add(productModel);
    notifyListeners();
  }

  void removeFavoriteProduct(ProductModel productModel) {
    _favoriteProductModel.remove(productModel);
    notifyListeners();
  }

  List<ProductModel> get getFavoriteProductList => _favoriteProductModel;
  // get User Data
  void getUserInfoFirebase() async {
    _userModel = await FirebaseFirestoreHelper.instance.getUserData();
    notifyListeners();
  }

  // update User Data
  void updateUserInfoFirebase(
      BuildContext context, UserModel userModel, File image) async {
    showLoaderDialogue(context);
    if (image == null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userModel.id)
          .set(userModel.toJson());
    } else {
      String imageUrl =
          await FirebaseStorageHelper.instance.uploadUserImage(image);
      _userModel = userModel.copyWith(image: imageUrl);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_userModel!.id)
          .set(_userModel!.toJson());
      notifyListeners();
    }
    Navigator.of(context).pop();
  }
}
