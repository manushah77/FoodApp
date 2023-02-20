import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:food_app_complete/providers/user_provider.dart';
import 'package:food_app_complete/screens/home_page.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import '../constant/colors.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  UserProvider? userProvider;
  late String phoneNo, smssent, verificationId;
  FirebaseAuth auth = FirebaseAuth.instance;
  String initialCountry = 'PAK';
  PhoneNumber number = PhoneNumber(isoCode: 'PAK');
  //google verification

  // Future _googleSignUp() async {
  //   try {
  //     final GoogleSignIn _googleSignIn = GoogleSignIn(
  //       scopes: ['email'],
  //     );
  //     final FirebaseAuth _auth = FirebaseAuth.instance;
  //
  //     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
  //     final GoogleSignInAuthentication? googleAuth =
  //         await googleUser?.authentication;
  //
  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth?.accessToken,
  //       idToken: googleAuth?.idToken,
  //     );
  //
  //     final User? user = (await _auth.signInWithCredential(credential)).user;
  //     // print("signed in " + user.displayName);
  //     userProvider!.addsUerData(
  //       currentUser: user,
  //       userEmail: user!.email,
  //       userImage: user.photoURL,
  //       userName: user.displayName,
  //       userPhone: user.phoneNumber,
  //     );
  //
  //     return user;
  //   } catch (e) {
  //     return e;
  //   }
  // }

  //phone verification

  Future<void> verifyPhone() async {
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      this.verificationId = verId;
    };
    final PhoneCodeSent smsCodeSent = (String verId, [int? forceCodeResend]) {
      this.verificationId = verId;
      smsCodeDialoge(context).then((value) {
        print("Code Sent");
      });
    } as PhoneCodeSent;
    final PhoneVerificationCompleted verifiedSuccess = (AuthCredential auth) {};
    final PhoneVerificationFailed verifyFailed = (FirebaseAuthException e) {
      print('${e.message}');
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNo,
      timeout:  Duration(seconds: 2),
      verificationCompleted: verifiedSuccess,
      verificationFailed: verifyFailed,
      codeSent: smsCodeSent,
      codeAutoRetrievalTimeout: autoRetrieve,
    );
  }

  Future smsCodeDialoge(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        var errorController;
        return AlertDialog(
          title: Text('Provide OTP'),
          content: PinCodeTextField(
            length: 6,
            obscureText: false,
            animationType: AnimationType.fade,
            animationDuration: Duration(milliseconds: 300),
            errorAnimationController: errorController,
            // Pas// s it here
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.underline,
              borderRadius: BorderRadius.circular(5),
              fieldHeight: 50,
              fieldWidth: 40,
              activeFillColor: Colors.white,
            ),
            onChanged: (value) {
              setState(() {
                this.smssent = value;
              });
            },
            appContext: context,
          ),
          contentPadding: EdgeInsets.all(10.0),
          actions: <Widget>[
            MaterialButton(
                onPressed: () {
                  var user = FirebaseAuth.instance.currentUser;
                  if (user != null) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  } else {
                    Navigator.of(context).pop();
                    signIn(smssent);
                  }
                },
                child: Text(
                  'Done',
                  style: TextStyle(color: Colors.blue),
                ))
          ],
        );
      },
    );
  }

  Future<void> signIn(String smsCode) async {
    final AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    try{
      await FirebaseAuth.instance.signInWithCredential(credential).then((user) {
        final User? users = FirebaseAuth.instance.currentUser;
        userProvider!.addsUerData(
          currentUser: users,
          userEmail: '',
          userPhone: users!.phoneNumber,
          userImage: 'https://icons.veryicon.com/png/o/miscellaneous/first/person-8.png',
          userName: 'User' + users.phoneNumber.toString() ,
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      });
    }
    catch (e) {
      print(e);
    }
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/a.jpg'), fit: BoxFit.cover),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 120,
                ),
                Text(
                  'Sign Up With',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 200,
                ),
                // InternationalPhoneNumberInput(
                //   onInputChanged: (PhoneNumber number) {
                //     this.phoneNo = number as String;
                //   },
                //   onInputValidated: (bool value) {
                //   },
                //   selectorConfig: SelectorConfig(
                //     selectorType: PhoneInputSelectorType.DIALOG,
                //   ),
                //   ignoreBlank: false,
                //   autoValidateMode: AutovalidateMode.disabled,
                //   selectorTextStyle: TextStyle(color: Colors.black),
                //   initialValue: number,
                //
                //   formatInput: true,
                //   keyboardType:
                //   TextInputType.numberWithOptions(signed: true, decimal: true),
                //   inputBorder: OutlineInputBorder(),
                //   onSaved: (PhoneNumber number) {
                //     print('On Saved: $number');
                //   },
                // ),

                Padding(
                  padding: const EdgeInsets.only(left: 16.0,right: 16),
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        fillColor: Colors.white10,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white,width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'Phone number',
                        hintStyle: TextStyle(color: Colors.white)),
                    onChanged: (value) {
                      this.phoneNo = value;
                    },
                  ),
                ),
                SizedBox(height: 100.0),
                MaterialButton(
                  minWidth: 200,
                  height: 50,
                  onPressed: verifyPhone,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    'Verify',
                    style: TextStyle(color: Colors.white),
                  ),
                  elevation: 7.0,
                  color: primaryColor,
                ),
                SizedBox(
                  height: 75,
                ),
                // Text(
                //   'Or',
                //   style: TextStyle(
                //     color: Colors.white,
                //     fontSize: 18,
                //     fontWeight: FontWeight.w400,
                //   ),
                //   textAlign: TextAlign.center,
                // ),
                SizedBox(
                  height: 20,
                ),
                // SignInButton(
                //   Buttons.Google,
                //   text: "Sign in with Google",
                //   onPressed: () async {
                //     await _googleSignUp().then(
                //       (value) => Navigator.pushReplacement(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) => HomePage(),
                //         ),
                //       ),
                //     );
                //   },
                // ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  'By signing in you are agreeing our\nTerm and Privacy Policy',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
