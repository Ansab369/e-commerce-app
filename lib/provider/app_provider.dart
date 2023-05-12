import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/models/product_model/product_model.dart';

class AppProvider with ChangeNotifier {
// CART
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
}
