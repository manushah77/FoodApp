import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_app_complete/auth/authentication.dart';
import 'package:food_app_complete/auth/signin_page.dart';
import 'package:food_app_complete/auth/splash.dart';
import 'package:food_app_complete/constant/colors.dart';
import 'package:food_app_complete/providers/check_out_provider.dart';
import 'package:food_app_complete/providers/product_provider.dart';
import 'package:food_app_complete/providers/review_cart_provider.dart';
import 'package:food_app_complete/providers/user_provider.dart';
import 'package:food_app_complete/providers/wish_list_provider.dart';
import 'package:food_app_complete/screens/home_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductProvider>(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider<ReviewCartProvider> (
          create: (context) => ReviewCartProvider(),
        ),
        ChangeNotifierProvider<WishListProvider> (
          create: (context) => WishListProvider(),
        ),
        ChangeNotifierProvider<CheckOutProvider> (
          create: (context) => CheckOutProvider(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ThemeData().colorScheme.copyWith(
            primary: primaryColor,
          ),
          primaryColor: primaryColor,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              // if (snapshot.hasData) {
              //   return HomePage();
              // }
              return SplashScreen();
            }),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
//"merchantInfo":{
//       "merchantId":"01234567890123456789",
//       "merchantName":"Example Merchant Name"
//     },
