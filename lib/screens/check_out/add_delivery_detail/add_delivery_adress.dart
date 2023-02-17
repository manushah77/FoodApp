import 'package:flutter/material.dart';
import 'package:food_app_complete/constant/colors.dart';
import 'package:food_app_complete/providers/check_out_provider.dart';
import 'package:food_app_complete/screens/check_out/google_map/google_map.dart';
import 'package:food_app_complete/widgets/custom-_text_field.dart';
import 'package:provider/provider.dart';

class AddDeliveryAdress extends StatefulWidget {
  const AddDeliveryAdress({Key? key}) : super(key: key);

  @override
  State<AddDeliveryAdress> createState() => _AddDeliveryAdressState();
}

enum AdressType {
  Home,
  Work,
  Other,
}

class _AddDeliveryAdressState extends State<AddDeliveryAdress> {
  var myType = AdressType.Home;

  @override
  Widget build(BuildContext context) {
    CheckOutProvider checkOutProvider = Provider.of(context);
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
          'Delivery Adress',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: 50,
        child: checkOutProvider.isLoading == false
            ? MaterialButton(
                onPressed: () {
                  checkOutProvider.validator(context, myType);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => AddDeliveryAdress(),
                  //   ),
                  // );
                },
                child: Text(
                  'Add Adress',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              )
            : Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView(
          children: [
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              label: 'First Name',
              keyboardType: TextInputType.text,
              controller: checkOutProvider.fname,
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              label: 'Last Name',
              keyboardType: TextInputType.text,
              controller: checkOutProvider.lname,
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              label: 'Mobile No',
              keyboardType: TextInputType.numberWithOptions(),
              controller: checkOutProvider.mobileNo,
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              label: 'Alternate Mobile No',
              keyboardType: TextInputType.numberWithOptions(),
              controller: checkOutProvider.altermobileNo,
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              label: 'Society',
              keyboardType: TextInputType.text,
              controller: checkOutProvider.society,
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              label: 'Street',
              keyboardType: TextInputType.text,
              controller: checkOutProvider.street,
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              label: 'Area',
              keyboardType: TextInputType.text,
              controller: checkOutProvider.area,
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              label: 'Land Mark',
              keyboardType: TextInputType.text,
              controller: checkOutProvider.landmark,
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              label: 'Postal Code',
              keyboardType: TextInputType.text,
              controller: checkOutProvider.pincode,
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              label: 'City',
              keyboardType: TextInputType.text,
              controller: checkOutProvider.city,
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CustomGoogleMap(),
                  ),
                );
              },
              child: Container(
                height: 50,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    checkOutProvider.setLocation?.latitude == null ?
                    Text('Set Location') : Text('Set Location Done'),
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            ListTile(
              title: Text('Adress Type*'),
            ),
            RadioListTile(
              value: AdressType.Home,
              groupValue: myType,
              title: Text('Home'),
              onChanged: (AdressType? value) {
                setState(() {
                  myType = value!;
                });
              },
              secondary: Icon(
                Icons.home_outlined,
                color: primaryColor,
              ),
              activeColor: primaryColor,
            ),
            RadioListTile(
              value: AdressType.Work,
              groupValue: myType,
              activeColor: primaryColor,
              title: Text('Work'),
              onChanged: (AdressType? value) {
                setState(() {
                  myType = value!;
                });
              },
              secondary: Icon(
                Icons.work_outline,
                color: primaryColor,
              ),
            ),
            RadioListTile(
              value: AdressType.Other,
              groupValue: myType,
              activeColor: primaryColor,
              title: Text('Other'),
              onChanged: (AdressType? value) {
                setState(() {
                  myType = value!;
                });
              },
              secondary: Icon(
                Icons.workspaces_outline,
                color: primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
