// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/provider/app_provider.dart';
import 'package:flutter_ecommerce/screens/cart/widgets/single_cart_item.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          title: Text(
            'My Cart',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: appProvider.getCartProductList.isEmpty
            ? Center(
                child: Text('No Products In Cart'),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView.separated(
                  itemCount: appProvider.getCartProductList.length,
                  separatorBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      height: 1.2,
                      width: double.infinity,
                      color: Colors.grey[350],
                    );
                  },
                  itemBuilder: (context, index) {
                    return CartItem(
                      productModel: appProvider.getCartProductList[index],
                    );
                  },
                ),
              ));
  }
}
