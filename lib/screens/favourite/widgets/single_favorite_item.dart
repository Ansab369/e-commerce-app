// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/constants/constants.dart';
import 'package:flutter_ecommerce/models/product_model/product_model.dart';
import 'package:flutter_ecommerce/provider/app_provider.dart';
import 'package:flutter_ecommerce/screens/product_datails/product_details.dart';
import 'package:provider/provider.dart';

class FavoriteItem extends StatefulWidget {
  ProductModel productModel;
  FavoriteItem({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  @override
  State<FavoriteItem> createState() => _FavoriteItemState();
}

class _FavoriteItemState extends State<FavoriteItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
//! image
        Container(
          height: 120,
          width: 130,
          decoration: BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: NetworkImage(widget.productModel.image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
//! name
            Text(
              widget.productModel.name,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
//! price
            Text(
              '\$ ${widget.productModel.price}',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 25),
//! cart icon
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ProductDetailsPage(singleProduct: widget.productModel),
                  ),
                );
              },
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Icon(Icons.shopping_cart),
                ),
              ),
            ),
          ],
        ),
        Spacer(),
//! close icon
        GestureDetector(
          onTap: () {
            AppProvider appProvider =
                Provider.of<AppProvider>(context, listen: false);
            appProvider.removeFavoriteProduct(widget.productModel);
            showMessage('Removed From Favorite');
          },
          child: Icon(Icons.close_rounded),
        ),
      ],
    );
  }
}
