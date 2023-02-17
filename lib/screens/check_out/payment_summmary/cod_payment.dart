import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app_complete/constant/colors.dart';
import 'package:food_app_complete/models/product_model.dart';
import 'package:food_app_complete/providers/product_provider.dart';
import 'package:food_app_complete/providers/review_cart_provider.dart';
import 'package:food_app_complete/screens/home_page.dart';
import 'package:provider/provider.dart';

class COD extends StatefulWidget {
  const COD({Key? key}) : super(key: key);

  @override
  State<COD> createState() => _CODState();
}

class _CODState extends State<COD> {
  @override
  Widget build(BuildContext context) {
   ProductProvider productProvider = Provider.of(context);
   productProvider.productModel!.ProductId;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        bottomNavigationBar: Container(
          height: 50,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: MaterialButton(
            onPressed: () async {
              await FirebaseFirestore.instance
                  .collection('ReviewCart')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .delete();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            },
            child: Text(
              'Done',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            color: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          elevation: 0,
          backgroundColor: primaryColor,
          title: Text('Order Done'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                'Your Order Has been Confirm',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Image.asset(
              'assets/images/giphy.gif',
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                'Our Rider is on way',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.black38),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Center(
              child: Text(
                'Keep your Payment Ready',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
