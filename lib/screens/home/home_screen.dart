// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/constants/constants.dart';
import 'package:flutter_ecommerce/firebase_helper/firebase_firestore_helper/firebase_firestore_helper.dart';
import 'package:flutter_ecommerce/models/category%20model/category_model.dart';
import 'package:flutter_ecommerce/models/product_model/product_model.dart';
import 'package:flutter_ecommerce/provider/app_provider.dart';
import 'package:flutter_ecommerce/screens/home/widgets/header_widget.dart';
import 'package:flutter_ecommerce/screens/home/widgets/shimmer_widgets.dart';
import 'package:flutter_ecommerce/screens/product_datails/product_details.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CategoryModel> categoryModelList = [];
  List<ProductModel> productModelList = [];
  bool isLoading = false;
  bool isLoadingProducts = false;
  int currentTab = 0;

// initstate
  @override
  void initState() {
    getCategoryList();
    super.initState();
  }

// load gategory name list,all products list
  void getCategoryList() async {
    setState(() {
      isLoading = true;
      isLoadingProducts = true;
    });
    categoryModelList = await FirebaseFirestoreHelper.instance.getCategories();
    productModelList = await FirebaseFirestoreHelper.instance.getAllProducts();
    setState(() {
      isLoading = false;
      isLoadingProducts = false;
    });
  }

// load gategory items
  void getCategoryViewList(String id) async {
    setState(() {
      isLoadingProducts = true;
    });
    productModelList =
        await FirebaseFirestoreHelper.instance.getCategoryViewProduct(id);
    setState(() {
      isLoadingProducts = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    ValueNotifier<int> selectedTabIndex = ValueNotifier<int>(0);
    AppProvider appProvider = Provider.of<AppProvider>(context);
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
                                setState(() {
                                  currentTab = index;
                                });
                                // selectedTabIndex.value = index;
                                getCategoryViewList(
                                    categoryModelList[index].id);
                              },
                              child: ValueListenableBuilder(
                                valueListenable: selectedTabIndex,
                                builder: (context, value, child) {
                                  print(selectedTabIndex.value);
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: index == currentTab
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
                                        color: index == currentTab
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
                isLoadingProducts
                    ? ShimmerProduct()
                    : GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: productModelList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 20.0,
                          crossAxisSpacing: 20.0,
                          childAspectRatio: 0.65,
                        ),
                        itemBuilder: (context, index) {
                          ProductModel singleProduct = productModelList[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailsPage(
                                      singleProduct: singleProduct),
                                ),
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      height: 180,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              singleProduct.image,
                                              scale: 10),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 12,
                                      top: 12,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            singleProduct.isFavorite =
                                                !singleProduct.isFavorite;
                                          });
                                          if (singleProduct.isFavorite) {
                                            appProvider.getFavoriteProductList
                                                .add(singleProduct);
                                            showMessage('Added to Favorite');
                                          } else {
                                            appProvider.getFavoriteProductList
                                                .remove(singleProduct);
                                            showMessage(
                                                'Removed from Favorite');
                                          }
                                        },
                                        child: Icon(
                                          Icons.favorite,
                                          color: appProvider
                                                  .getFavoriteProductList
                                                  .contains(singleProduct)
                                              ? Colors.black
                                              : Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          singleProduct.name,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Colors.black.withOpacity(0.6),
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
                            ),
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

//! product model

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
