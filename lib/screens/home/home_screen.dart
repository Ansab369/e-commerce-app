// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/constants/data.dart';
import 'package:flutter_ecommerce/firebase_helper/firebase_firestore_helper/firebase_firestore_helper.dart';
import 'package:flutter_ecommerce/models/category%20model/category_model.dart';
import 'package:flutter_ecommerce/models/product_model/product_model.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CategoryModel> categoryModelList = [];
  List<ProductModel> productModelList = [];
  bool isLoading = false;
  @override
  void initState() {
    getCategoryList();
    super.initState();
  }

  void getCategoryList() async {
    setState(() {
      isLoading = true;
    });
    categoryModelList = await FirebaseFirestoreHelper.instance.getCategories();
    productModelList = await FirebaseFirestoreHelper.instance.getAllProducts();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    ValueNotifier<int> selectedTabIndex = ValueNotifier<int>(0);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                DiscoverHeader(),
                SizedBox(height: 20),
                SearchTextField(),
                SizedBox(height: 20),
                //* shimmer effect
                isLoading
                    ? ShimmerTabBar()
                    : SizedBox(
                        height: 40,
                        width: double.infinity,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: categoryModelList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                selectedTabIndex.value = index;
                              },
                              child: ValueListenableBuilder(
                                valueListenable: selectedTabIndex,
                                builder: (context, value, child) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: index == selectedTabIndex.value
                                          ? Colors.black
                                          : Colors.grey[200],
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: 20,
                                    ),
                                    margin: EdgeInsets.only(right: 10),
                                    child: Text(
                                      categoryModelList[index].name,
                                      style: TextStyle(
                                        color: index == selectedTabIndex.value
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 18,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                SizedBox(height: 20),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: productModelList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20.0, // Spacing between rows
                    crossAxisSpacing: 20.0, // Spacing between columns
                    childAspectRatio: 0.76,
                  ),
                  itemBuilder: (context, index) {
                    ProductModel singleProduct = productModelList[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 180,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(singleProduct.image,
                                      scale: 10),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              right: 12,
                              top: 12,
                              child: Icon(
                                Icons.favorite,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  singleProduct.name,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black.withOpacity(0.6),
                                  ),
                                ),
                                SizedBox(height: 3),
                                Text(
                                  '\$ ${singleProduct.price}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Icon(Icons.shopping_cart),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ShimmerTabBar extends StatelessWidget {
  const ShimmerTabBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.0,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemCount: 10,
          itemBuilder: (context, index) {
            return Shimmer.fromColors(
              baseColor: Colors.grey.shade200,
              highlightColor: Colors.grey.shade400,
              child: Container(
                width: 80,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                margin: EdgeInsets.only(right: 10),
              ),
            );
          }),
    );
  }
}

//! product model

List<ProductModel> allProducts = [
  ProductModel(
    image:
        'https://image.architonic.com/pro2-2/20084003/nubes-modular-sofa-right-armrest-pro-b-arcit18.jpg',
    id: '1',
    isFavorite: false,
    name: 'sofa',
    price: '100',
    discription:
        'discription fedf fde fekfkhe efihekhf eiy fh feifh efiehfiehyfbiehf eifyeihef efiyefgief efhfe fefef fef feifeihf ',
    status: 'pending',
  ),
  ProductModel(
    image:
        'https://image.architonic.com/pro2-2/20235658/pantry-storage--1-oil-oak-02-pro-b-arcit18.jpg',
    id: '2',
    isFavorite: false,
    name: 'Light',
    price: '1302',
    discription:
        'discription fedf fde fekfkhe efihekhf eiy fh feifh efiehfiehyfbiehf eifyeihef efiyefgief efhfe fefef fef feifeihf ',
    status: 'pending',
  ),
  ProductModel(
    image:
        'https://image.architonic.com/pro2-2/20251626/vega--01-0000-pro-b-arcit18.jpg',
    id: '3',
    isFavorite: false,
    name: 'Litter Bin',
    price: '182',
    discription:
        'discription fedf fde fekfkhe efihekhf eiy fh feifh efiehfiehyfbiehf eifyeihef efiyefgief efhfe fefef fef feifeihf ',
    status: 'pending',
  ),
  ProductModel(
    image: 'https://image.architonic.com/img_pro2-1/138/1033/saturno-02-h.jpg',
    id: '4',
    isFavorite: false,
    name: 'Mirror',
    price: '91',
    discription:
        'discription fedf fde fekfkhe efihekhf eiy fh feifh efiehfiehyfbiehf eifyeihef efiyefgief efhfe fefef fef feifeihf ',
    status: 'pending',
  ),
];

class DiscoverHeader extends StatelessWidget {
  const DiscoverHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Discover',
          style: TextStyle(
              color: Colors.black, fontSize: 35, fontWeight: FontWeight.bold),
        ),
        Icon(
          Icons.notifications_none_outlined,
          size: 26,
        )
      ],
    );
  }
}

class SearchTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.search),
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search Products',
                  hintStyle: TextStyle(color: Colors.black.withOpacity(0.5))),
            ),
          ),
        ],
      ),
    );
  }
}
