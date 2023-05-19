// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:flutter_ecommerce/provider/app_provider.dart';
import 'package:provider/provider.dart';

class AccountScreeen extends StatelessWidget {
  const AccountScreeen({super.key});

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              appProvider.getUserInformation!.image != null
                  ? CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                          'https://image.tmdb.org/t/p/w500/bT3IpP7OopgiVuy6HCPOWLuaFAd.jpg'),
                    )
                  : Icon(
                      Icons.person_rounded,
                      size: 90,
                    ),
              SizedBox(width: 40),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appProvider.getUserInformation!.name,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    appProvider.getUserInformation!.email,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Edit',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.blueGrey,
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 30),
          //! add inkWll() for each item
          ProfileOptionWidgets(
            title: 'My Orders',
            subTitle: '10 Orders',
          ),
          ProfileOptionWidgets(
            title: 'Manage Address',
            subTitle: 'Change or Add Address',
          ),
          ProfileOptionWidgets(
            title: 'About us',
            subTitle: 'Check about our Vision',
          ),
          ProfileOptionWidgets(
            title: 'Support',
            subTitle: 'Get Support From Our Team',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextButton(
              onPressed: () {
                FirebaseAuthHelper.instance.logOut();
              },
              style: TextButton.styleFrom(
                minimumSize: Size(double.infinity, 40),
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Log Out',
                  style: TextStyle(fontSize: 17),
                ),
              ),
            ),
          ),
          Spacer(),
          Text('Version 1.0.0'),
          SizedBox(height: 100),
        ],
      ),
    );
  }
}

class ProfileOptionWidgets extends StatelessWidget {
  final String title;
  final String subTitle;

  // var onTap;
  const ProfileOptionWidgets({
    Key? key,
    required this.title,
    required this.subTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: EdgeInsets.all(12),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(subTitle),
            ],
          ),
          Icon(Icons.arrow_forward_ios_sharp)
        ],
      ),
    );
  }
}
