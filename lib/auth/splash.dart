import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app_complete/auth/signin_page.dart';
import 'package:food_app_complete/constant/colors.dart';
import 'package:food_app_complete/screens/home_page.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.userChanges().listen(
      (user) {
        Timer(
          Duration(seconds: 3),
          () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (BuildContext context) =>
                  user != null ? HomePage() : SignIn(),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/a.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Center(
                //   child: Image.asset(
                //     'assets/images/5.png',
                //   ),
                // ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  'S & S Mall',
                  style: GoogleFonts.blackOpsOne(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w600
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'All Product at One Place',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w600
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 5,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
