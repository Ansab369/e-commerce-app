// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/constants/constants.dart';

import 'package:flutter_ecommerce/models/product_model/product_model.dart';
import 'package:flutter_ecommerce/provider/app_provider.dart';
import 'package:provider/provider.dart';

class CartItem extends StatefulWidget {
  ProductModel productModel;
  CartItem({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  int quantity = 1;
  @override
  void initState() {
    quantity = widget.productModel.quantity ?? 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
            Text(
              widget.productModel.name,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              '\$ ${widget.productModel.price}',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 25),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    if (quantity >= 1) {
                      setState(() {
                        quantity--;
                      });
                    }
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Icon(Icons.remove),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    quantity.toString(),
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (quantity >= 0) {
                      setState(() {
                        quantity++;
                      });
                    }
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Icon(Icons.add),
                  ),
                ),
              ],
            ),
          ],
        ),
        Spacer(),
        GestureDetector(
            onTap: () {
              AppProvider appProvider =
                  Provider.of<AppProvider>(context, listen: false);
              appProvider.removeCartProduct(widget.productModel);
              showMessage('Removed From Cart');
            },
            child: Icon(Icons.close_rounded)),
      ],
    );
  }
}
