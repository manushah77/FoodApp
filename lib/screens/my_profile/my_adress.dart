import 'package:flutter/material.dart';
import 'package:food_app_complete/constant/colors.dart';
import 'package:food_app_complete/models/delivery_adress_model.dart';
import 'package:food_app_complete/providers/check_out_provider.dart';
import 'package:food_app_complete/screens/check_out/delivery_detail/delivery_detail.dart';
import 'package:food_app_complete/screens/check_out/delivery_detail/single_delivery_item.dart';
import 'package:provider/provider.dart';

class MyAdress extends StatefulWidget {
  const MyAdress({Key? key}) : super(key: key);

  @override
  State<MyAdress> createState() => _MyAdressState();
}

class _MyAdressState extends State<MyAdress> {
  DeliveryAdressModel? value;

  @override
  Widget build(BuildContext context) {
    CheckOutProvider deliveryAdressProvider = Provider.of(context);
    deliveryAdressProvider.getDeliveryAdressDara();
    return Scaffold(
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
          'Current Adress',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: MaterialButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => DeliveryDetail(),
              ),
            );
          },
          child: Text(
            'Change Delivery Adress',
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
          deliveryAdressProvider.getDeliveryAdressList.isEmpty
              ? Container(
                  child: Center(
                    child: Text('Adress No Added'),
                  ),
                )
              : Column(
                  children:
                      deliveryAdressProvider.getDeliveryAdressList.map((e) {
                    setState(() {
                      value = e;
                    });
                    return Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: primaryColor,
                                    width: 1
                                )
                            ),
                            child: Row(
                              children: [
                                Text(
                                  'Name: ',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  '${e.fname} ${e.lname}',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: primaryColor,
                                width: 1
                              )
                            ),
                            child: Row(
                              children: [
                                Text(
                                  'Phone Number: ',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  '${e.mobileNo}',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: primaryColor,
                                    width: 1
                                )
                            ),
                            child: Row(
                              children: [
                                Text(
                                  'Society: ',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  '${e.society}',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: primaryColor,
                                    width: 1
                                )
                            ),
                            child: Row(
                              children: [
                                Text(
                                  'Street No: ',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  '${e.street}',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: primaryColor,
                                    width: 1
                                )
                            ),
                            child: Row(
                              children: [
                                Text(
                                  'City: ',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  '${e.city}',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: primaryColor,
                                    width: 1
                                )
                            ),
                            child: Row(
                              children: [
                                Text(
                                  'Postal Code: ',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  '${e.postalcode}',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: primaryColor,
                                    width: 1
                                )
                            ),
                            child: Row(
                              children: [
                                Text(
                                  'Land Mark: ',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  '${e.landmark}',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),


                      ],
                    );
                  }).toList(),
                )
        ],
      ),
    );
  }
}
