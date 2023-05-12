import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/models/product_model/product_model.dart';

class AppProvider with ChangeNotifier {
  List<ProductModel> _cartProductModel = [];

  void addCartProduct(ProductModel productModel) {
    _cartProductModel.add(productModel);
    notifyListeners();
  }

  void removeCartProduct(ProductModel productModel) {
    _cartProductModel.remove(productModel);
    notifyListeners();
  }

  List<ProductModel> get getCartProductList => _cartProductModel;
}
