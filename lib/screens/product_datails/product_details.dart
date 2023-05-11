// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/models/product_model/product_model.dart';

class ProductDetailsPage extends StatefulWidget {
  final ProductModel singleProduct;

  ProductDetailsPage({
    required this.singleProduct,
  });

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int quantity = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 1.15,
                        height: 400,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(40)),
                          image: DecorationImage(
                              image: NetworkImage(widget.singleProduct.image),
                              fit: BoxFit.cover),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 30, left: 30),
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 10,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Icon(Icons.arrow_back),
                    ),
                  ),
                  Positioned(
                    bottom: 45,
                    left: 25,
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 10,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Icon(Icons.favorite_border),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.singleProduct.name,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[450],
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              '\$${widget.singleProduct.price}',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
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
                    SizedBox(height: 16),
                    Text(
                      widget.singleProduct.discription,
                      style: TextStyle(
                          fontSize: 16, color: Colors.black.withOpacity(0.6)),
                    ),
                    SizedBox(height: 80),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  side: BorderSide(
                    color: Colors.black,
                    width: 2.0,
                  ),
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () async {},
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      Icons.shopping_cart,
                      color: Colors.black,
                    )),
              ),
              SizedBox(width: 10),
              Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {},
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Buy Now',
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // child: TextButton(
          //   style: TextButton.styleFrom(
          //     minimumSize: Size(double.infinity, 40),
          //     foregroundColor: Colors.white,
          //     backgroundColor: Colors.black,
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(10),
          //     ),
          //   ),
          //   onPressed: () async {},
          //   child: Padding(
          //     padding: EdgeInsets.all(10),
          //     child: Text(
          //       'Add To Cart',
          //       style: TextStyle(fontSize: 17),
          //     ),
          //   ),
          // ),
        ),
      ),
    );
  }
}
