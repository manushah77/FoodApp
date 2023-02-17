import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app_complete/constant/colors.dart';
import 'package:food_app_complete/models/product_model.dart';
import 'package:food_app_complete/providers/review_cart_provider.dart';
import 'package:food_app_complete/screens/review_cart/review_cart.dart';
import 'package:provider/provider.dart';

class Counter extends StatefulWidget {
  String? productName;
  String? productImage;
  String? productId;
  String? productQuantity;
  int? productPrice;
  var productUnit;

  Counter({
    this.productUnit,
    this.productName,
    this.productPrice,
    this.productImage,
    this.productId,
    this.productQuantity,
  });

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int count = 1 ;
  bool isTrue = false;

  getAddAndQantity() async {
    FirebaseFirestore.instance
        .collection('ReviewCart')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('YourReviewCart')
        .doc(widget.productId)
        .get()
        .then(
          (value) => {
            if (this.mounted)
              {
                if(value.exists)
               {
                 setState(
                       () {
                         count = value.get('cartQuantity');
                     isTrue = value.get('isAdd');
                   },
                 )
               }
              }
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    getAddAndQantity();
    ReviewCartProvider reviewCartProvider = Provider.of(context);
    return Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.grey.withOpacity(0.4),
          ),
        ),
        child: isTrue == true
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {

                      if (count == 1) {
                        setState(() {
                          isTrue = false;
                        });
                      reviewCartProvider.reviewCartDataDelete(widget.productId);
                      }
                      else if (count > 1) {
                        setState(() {
                          count--;
                        });
                        reviewCartProvider.updateCartData(
                          cartId: widget.productId,
                          cartName: widget.productName,
                          cartImage: widget.productImage,
                          cartPrice: widget.productPrice,
                          cartQuantity: count,

                        );
                      }

                    },
                    child: Icon(
                      Icons.remove,
                      size: 15,
                    ),
                  ),
                  Text(
                    '${count}',
                    style: TextStyle(
                        color: primaryColor, fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        count++;
                      });
                      reviewCartProvider.updateCartData(
                        cartId: widget.productId,
                        cartName: widget.productName,
                        cartImage: widget.productImage,
                        cartPrice: widget.productPrice,
                        cartQuantity: count,
                      );
                    },
                    child: Center(
                      child: Icon(
                        Icons.add,
                        size: 15,
                      ),
                    ),
                  ),
                ],
              )
            : Center(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      isTrue = true;
                    });
                    reviewCartProvider.addsCartData(
                      cartId: widget.productId,
                      cartName: widget.productName,
                      cartImage: widget.productImage,
                      cartPrice: widget.productPrice,
                      cartQuantity: count,
                      cartUnit: widget.productUnit,
                    );
                  },
                  child: Text(
                    'ADD',
                    style: TextStyle(
                      color: primaryColor,
                    ),
                  ),
                ),
              ));
  }
}
