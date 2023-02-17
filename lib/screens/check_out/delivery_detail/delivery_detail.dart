import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app_complete/constant/colors.dart';
import 'package:food_app_complete/models/delivery_adress_model.dart';
import 'package:food_app_complete/providers/check_out_provider.dart';
import 'package:food_app_complete/screens/check_out/add_delivery_detail/add_delivery_adress.dart';
import 'package:food_app_complete/screens/check_out/delivery_detail/single_delivery_item.dart';
import 'package:food_app_complete/screens/check_out/payment_summmary/payment_summary.dart';
import 'package:provider/provider.dart';

class DeliveryDetail extends StatefulWidget {
  const DeliveryDetail({Key? key}) : super(key: key);

  @override
  State<DeliveryDetail> createState() => _DeliveryDetailState();
}

class _DeliveryDetailState extends State<DeliveryDetail> {
  DeliveryAdressModel? value;
  @override
  Widget build(BuildContext context) {
    CheckOutProvider deliveryAdressProvider = Provider.of(context);
    deliveryAdressProvider.getDeliveryAdressDara();
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
            'Delivery Detail',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: primaryColor,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddDeliveryAdress(),
              ),
            );
          },
        ),
        bottomNavigationBar: Container(
          height: 50,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: MaterialButton(
            onPressed: () {
              deliveryAdressProvider.getDeliveryAdressList.isEmpty
                  ? Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddDeliveryAdress(),
                      ),
                    )
                  : Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentSummary(
                          deliveryAderss: value!,
                        ),
                      ),
                    );
            },
            child: deliveryAdressProvider.getDeliveryAdressList.isEmpty
                ? Text(
                    'Add Delivery Adress',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )
                : Text(
                    'Payment Summary',
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
        body: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.location_history),
              title: Text('Deliver To'),
            ),
            Divider(
              height: 2,
            ),
            deliveryAdressProvider.getDeliveryAdressList.isEmpty
                ? Container(
                    child: Center(
                      child: Text('NO DATA'),
                    ),
                  )
                : Column(
                    children:
                        deliveryAdressProvider.getDeliveryAdressList.map((e) {
                          setState(() {
                       value  = e;
                          });
                      return SingleDeliveryItem(
                        adress:
                            'area ${e.area},street ${e.street}, society ${e.society}, pindcode ${e.postalcode}',
                        adressType:
                            '${e.adressType == 'AdressTypes.Other' ? 'Other' : e.adressType == 'AdressType.Home' ? 'Home' : 'Work'}',
                        title: '${e.fname} ${e.lname}',
                        number: '${e.mobileNo}',
                      );
                    }).toList(),
                  )
          ],
        ),
      ),
    );
  }
}
