import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app_complete/constant/colors.dart';

class RaiseAComplain extends StatefulWidget {
  const RaiseAComplain({Key? key}) : super(key: key);

  @override
  State<RaiseAComplain> createState() => _RaiseAComplainState();
}

class _RaiseAComplainState extends State<RaiseAComplain> {
  TextEditingController complainC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        bottomNavigationBar: Container(
          height: 50,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: MaterialButton(
            onPressed: () {
              complainC.clear();
              //  complainC.text.isEmpty == '' ?   Fluttertoast.showToast(
              //   msg: 'Please Enter Complain',
              // ):
              Fluttertoast.showToast(
                msg: 'Your Request is under Proess, We will Contact you soon',
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
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0,
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
            'Raise A Complain',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
              child: Text(
                'We Are here for you 24/7,Do yo facing some issue..?',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
              child: Row(
                children: [
                  Text(
                    'Raise a Complain:',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
              child: TextFormField(
                controller: complainC,
                decoration: InputDecoration(
                  hintText: 'Enter Complain',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.black38)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: primaryColor,
                      width: 2,
                    ),
                  ),
                ),
                maxLines: 7,
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
