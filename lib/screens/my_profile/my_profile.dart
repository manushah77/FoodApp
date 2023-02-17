import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app_complete/auth/signin_page.dart';
import 'package:food_app_complete/constant/colors.dart';
import 'package:food_app_complete/models/user_model.dart';
import 'package:food_app_complete/screens/check_out/delivery_detail/delivery_detail.dart';
import 'package:food_app_complete/screens/my_profile/my_adress.dart';
import 'package:food_app_complete/screens/review_cart/review_cart.dart';
import 'package:food_app_complete/widgets/drawer.dart';

class MyProfile extends StatefulWidget {
  UserModel? userdata;

  MyProfile({this.userdata});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameC = TextEditingController();

  @override
  Widget listTile(
      {required IconData icon,
      required String title,
      required Function ontap}) {
    return Column(
      children: [
        Divider(
          height: 1,
        ),
        ListTile(
          onTap: () => ontap(),
          leading: Icon(
            icon,
            size: 25,
            color: Colors.white,
          ),
          title: Text(
            title,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
          trailing: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_forward_ios,
              size: 22,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: primaryColor,
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
          'My Profile',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
      body: Form(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 100,
                  color: primaryColor,
                ),
                Container(
                  height: 563,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                    color: scafoldColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                  ),
                  child: ListView(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 80,
                            width: 250,
                            padding: EdgeInsets.only(left: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${widget.userdata!.userName}',
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '${widget.userdata!.userEmail}',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                              content: Form(
                                                key: _formKey,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text('Name'),
                                                      ],
                                                    ),
                                                    TextFormField(
                                                      decoration:
                                                          InputDecoration(
                                                              hintText:
                                                                  'Update Name'),
                                                      controller: nameC,
                                                      validator: (v) {
                                                        if (v == '') {
                                                          return 'Enter Name';
                                                        }
                                                      },
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    MaterialButton(
                                                      onPressed: () async {
                                                        if (_formKey
                                                            .currentState!
                                                            .validate()) {
                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'userData')
                                                              .doc(widget
                                                                  .userdata!
                                                                  .userUid)
                                                              .update({
                                                            'userName':
                                                                nameC.text,
                                                            // 'userEmail': emailC.text,
                                                          });
                                                          Navigator.pop(
                                                              context);
                                                        }
                                                      },
                                                      color: primaryColor,
                                                      child: Text(
                                                        'Update',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      minWidth: 200,
                                                      height: 50,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          30,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ));
                                  },
                                  child: CircleAvatar(
                                    radius: 15,
                                    backgroundColor: primaryColor,
                                    child: CircleAvatar(
                                      backgroundColor: scafoldColor,
                                      radius: 12,
                                      child: Icon(
                                        Icons.edit,
                                        color: primaryColor,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      listTile(
                          icon: Icons.shopping_bag_outlined,
                          title: 'My Order',
                          ontap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ReviewCart(),
                              ),
                            );
                          }),
                      listTile(
                          icon: Icons.location_on_outlined,
                          title: 'My Delivery Adress',
                          ontap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyAdress(),
                              ),
                            );
                          }),
                      listTile(
                          icon: Icons.people_outlined,
                          title: 'Refer A Friends',
                          ontap: () {
                            Fluttertoast.showToast(msg: 'Working In Process');
                          }),
                      listTile(
                          icon: Icons.file_copy_outlined,
                          title: 'Term & Conditions',
                          ontap: () {
                            Fluttertoast.showToast(msg: 'Working In Process');
                          }),
                      // listTile(
                      //     icon: Icons.policy_outlined,
                      //     title: 'Privacy Policy',
                      //     ontap: () {
                      //       Fluttertoast.showToast(msg: 'Working In Process');
                      //     }),
                      // listTile(
                      //     icon: Icons.border_color,
                      //     title: 'Myanage Orders',
                      //     ontap: () {}),
                      listTile(
                          icon: Icons.logout_outlined,
                          title: 'Log Out',
                          ontap: () {
                            signOut();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignIn(),
                              ),
                            );
                          }),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40.0, left: 245),
              child: CircleAvatar(
                radius: 50,
                backgroundColor: primaryColor,
                child: CircleAvatar(
                  backgroundColor: scafoldColor,
                  backgroundImage: NetworkImage('${widget.userdata!.userImage}' ??
                      'https://media.istockphoto.com/id/1335941248/photo/shot-of-a-handsome-young-man-standing-against-a-grey-background.jpg?b=1&s=170667a&w=0&k=20&c=Dl9uxPY_Xn159JiazEj0bknMkLxFdY7f4tK1GtOGmis='),
                  radius: 45,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
    User? user = FirebaseAuth.instance.currentUser;
  }
}
