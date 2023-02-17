import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app_complete/constant/colors.dart';
import 'package:food_app_complete/models/delivery_adress_model.dart';
import 'package:food_app_complete/providers/check_out_provider.dart';
import 'package:food_app_complete/providers/product_provider.dart';
import 'package:food_app_complete/providers/review_cart_provider.dart';
import 'package:food_app_complete/screens/check_out/delivery_detail/delivery_detail.dart';
import 'package:food_app_complete/screens/check_out/delivery_detail/single_delivery_item.dart';
import 'package:food_app_complete/screens/check_out/payment_summmary/cod_payment.dart';
import 'package:food_app_complete/screens/check_out/payment_summmary/my_google_pay.dart';
import 'package:food_app_complete/screens/check_out/payment_summmary/order_item.dart';
import 'package:provider/provider.dart';

class PaymentSummary extends StatefulWidget {
  final DeliveryAdressModel deliveryAderss;

  PaymentSummary({required this.deliveryAderss});

  @override
  State<PaymentSummary> createState() => _PaymentSummaryState();
}

enum AdressType {
  CashOnDelivery,
  Card,
}

class _PaymentSummaryState extends State<PaymentSummary> {
  var myType = AdressType.CashOnDelivery;

  double discont = 30.0;
  double discountValue = 0;
  double total = 0;
  double charges = 3.7;
  double totalPrice = 0.0;

  @override
  Widget build(BuildContext context) {
    ReviewCartProvider reviewCartProvider = Provider.of(context);
    reviewCartProvider.getReviewCartData();
    double totalPrice = reviewCartProvider.getTotalPrice();
    discountValue = (totalPrice * discont) / 100;
    total = totalPrice - discountValue;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
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
          backgroundColor: primaryColor,
          title: Text(
            'Payment Summary',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        bottomNavigationBar: ListTile(
          title: Text('Total Amount'),
          subtitle: Text(
            '\$${total + 5 ?? totalPrice}',
            style: TextStyle(
              color: Colors.green[900],
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          trailing: Container(
            width: 160,
            child: MaterialButton(
              onPressed: () async {
                if (myType == AdressType.CashOnDelivery) {
                   FirebaseFirestore.instance
                      .collection('OrderConfirmation')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .set({
                    'totalPrice': total,
                    'totalItems':
                    reviewCartProvider.getReviewCartDataList.length,
                    'totalDiscount': discont,
                    // 'items': reviewCartProvider.getReviewCartDataList.toList(),
                  });

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => COD(),
                    ),
                  );

                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyGooglePay(),
                    ),
                  );
                }
                //
              },
              child: Text(
                'Place Order',
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
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 10),
          child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  SingleDeliveryItem(
                    adress:
                        'area ${widget.deliveryAderss.area},street ${widget.deliveryAderss.street}, society ${widget.deliveryAderss.society}, pindcode ${widget.deliveryAderss.postalcode}',
                    adressType:
                        '${widget.deliveryAderss.adressType == 'AdressTypes.Other' ? 'Other' : widget.deliveryAderss.adressType == 'AdressType.Home' ? 'Home' : 'Work'}',
                    title:
                        '${widget.deliveryAderss.fname} ${widget.deliveryAderss.lname}',
                    number: '${widget.deliveryAderss.mobileNo}',
                  ),
                  Divider(),
                  ExpansionTile(
                    children: reviewCartProvider.getReviewCartDataList.map((e) {
                      return OrderItem(
                        reviewCartModel: e,
                      );
                    }).toList(),
                    title: Text(
                        'Order ${reviewCartProvider.getReviewCartDataList.length} Item'),
                  ),
                  ListTile(
                    minVerticalPadding: 5,
                    title: Text(
                      'Sub Total',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: Text(
                      '\$${totalPrice + 5}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    minVerticalPadding: 5,
                    title: Text(
                      'Discount',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black38,
                      ),
                    ),
                    trailing: Text(
                      '\%${discont}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    minVerticalPadding: 5,
                    title: Text(
                      'Delivery Charges',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black38,
                      ),
                    ),
                    trailing: Text(
                      '\$${5}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Divider(),
                  RadioListTile(
                    value: AdressType.CashOnDelivery,
                    groupValue: myType,
                    title: Text('Cash On Delivery'),
                    onChanged: (AdressType? value) {
                      setState(() {
                        myType = value!;
                      });
                    },
                    secondary: Icon(
                      Icons.attach_money_outlined,
                      color: primaryColor,
                    ),
                    activeColor: primaryColor,
                  ),
                  RadioListTile(
                    value: AdressType.Card,
                    groupValue: myType,
                    title: Text('Card'),
                    onChanged: (AdressType? value) {
                      setState(() {
                        myType = value!;
                      });
                    },
                    secondary: Icon(
                      Icons.payment_outlined,
                      color: primaryColor,
                    ),
                    activeColor: primaryColor,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
