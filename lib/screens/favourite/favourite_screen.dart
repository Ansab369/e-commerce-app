// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/provider/app_provider.dart';
import 'package:flutter_ecommerce/screens/favourite/widgets/single_favorite_item.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

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
          'My Favorite',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: appProvider.getFavoriteProductList.isEmpty
          ? Center(
              child: Text('No Products In Favorite'),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.separated(
                itemCount: appProvider.getFavoriteProductList.length,
                separatorBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 15),
                    height: 1.2,
                    width: double.infinity,
                    color: Colors.grey[350],
                  );
                },
                itemBuilder: (context, index) {
                  return FavoriteItem(
                    productModel: appProvider.getFavoriteProductList[index],
                  );
                },
              ),
            ),
    );
  }
}
