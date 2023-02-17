import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app_complete/models/delivery_adress_model.dart';
import 'package:location/location.dart';

class CheckOutProvider with ChangeNotifier {
  bool isLoading = false;

  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController mobileNo = TextEditingController();
  TextEditingController altermobileNo = TextEditingController();
  TextEditingController society = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController landmark = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController area = TextEditingController();
  TextEditingController pincode = TextEditingController();
  LocationData? setLocation;

  void validator(context, myType) async {
    if (fname.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Enter First Name');
    } else if (lname.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Enter Last Name');
    } else if (mobileNo.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Enter Mobile Number');
    } else if (altermobileNo.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Enter alternate Mobile Number');
    } else if (society.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Enter Societ Name');
    } else if (street.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Enter Street Number');
    } else if (landmark.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Enter LandMark Name');
    } else if (city.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Enter Cit Name');
    } else if (pincode.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Enter PostalCode Name');
    } else if (area.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Enter Area');
    } else if (setLocation == null) {
      Fluttertoast.showToast(msg: 'Set Location is Empty');
    } else {
      isLoading = true;
      notifyListeners();

      await FirebaseFirestore.instance
          .collection('AddDeliveryAdress')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        'firstName': fname.text,
        'lastName': lname.text,
        'mobileNo': mobileNo.text,
        'altermobileNo': altermobileNo.text,
        'society': society.text,
        'street': street.text,
        'city': city.text,
        'landMark': landmark.text,
        'postalCode': pincode.text,
        'area': area.text,
        "adressType": myType.toString(),
        'latitude': setLocation!.latitude,
        'longitude': setLocation!.longitude,
      }).then((value) async {
        isLoading = false;
        notifyListeners();
        Fluttertoast.showToast(msg: 'Add your Delivery Adress');
        Navigator.of(context).pop();
      });
      notifyListeners();
    }
  }


List<DeliveryAdressModel> deliveryAdressList = [];
   getDeliveryAdressDara() async {
     List<DeliveryAdressModel> newlist = [];

     DeliveryAdressModel deliveryAdressModel;
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('AddDeliveryAdress')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (snapshot.exists) {
      deliveryAdressModel = DeliveryAdressModel(
        fname: snapshot.get('firstName'),
        lname: snapshot.get('lastName'),
        mobileNo: snapshot.get('mobileNo'),
        alterrmobileNo: snapshot.get('altermobileNo'),
        society: snapshot.get('society'),
        street: snapshot.get('street'),
        city: snapshot.get('city'),
        area: snapshot.get('area'),
        postalcode: snapshot.get('postalCode'),
        landmark: snapshot.get('landMark'),
        adressType: snapshot.get('adressType'),
      );
      newlist.add(deliveryAdressModel);
      notifyListeners();

    }
    deliveryAdressList = newlist;
    notifyListeners();
  }

  List<DeliveryAdressModel> get getDeliveryAdressList {
     return deliveryAdressList;
  }

}
