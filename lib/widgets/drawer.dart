import 'package:flutter/material.dart';
import 'package:food_app_complete/constant/colors.dart';
import 'package:food_app_complete/providers/user_provider.dart';
import 'package:food_app_complete/screens/my_profile/my_profile.dart';
import 'package:food_app_complete/screens/raise_a_complain/raise_a_complain.dart';
import 'package:food_app_complete/screens/review_cart/review_cart.dart';
import 'package:food_app_complete/screens/wishList/wish_list.dart';

class DrawerSide extends StatefulWidget {
  UserProvider? userProvider;

  DrawerSide({this.userProvider});

  @override
  State<DrawerSide> createState() => _DrawerSideState();
}

class _DrawerSideState extends State<DrawerSide> {
  Widget listTile(
      {required IconData icon,
      required String title,
      required Function ontap}) {
    return ListTile(
      onTap: () => ontap(),
      leading: Icon(
        icon,
        size: 32,
        color: Colors.white,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      trailing: IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.arrow_forward_ios,
          size: 15,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var userData = widget.userProvider!.currentUserData;
    return Drawer(
      child: Container(
        color: primaryColor,
        child: ListView(
          children: [
            DrawerHeader(
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.yellow,
                    radius: 43,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage('${userData.userImage}'),
                      radius: 40,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${userData.userName}',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${userData.userEmail}',overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white,fontSize: 12),
                      ),
                      // Container(
                      //   height: 30,
                      //   decoration: BoxDecoration(
                      //       border: Border.all(color: Colors.white),
                      //       borderRadius: BorderRadius.circular(20)),
                      //   child: MaterialButton(
                      //     onPressed: () {},
                      //     child: Text(
                      //       'LOGIN',
                      //       style: TextStyle(color: Colors.white),
                      //     ),
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(20),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
            listTile(icon: Icons.home_outlined, title: 'Home', ontap: () {
              Navigator.pop(context);
            }),
            listTile(
                icon: Icons.person_outline,
                title: 'Profile',
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyProfile(userdata: userData ,),
                    ),
                  );
                }),
            listTile(
              icon: Icons.shopping_bag_outlined,
              title: 'Review Cart',
              ontap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReviewCart(),
                  ),
                );
              },
            ),
            // listTile(
            //     icon: Icons.doorbell_outlined,
            //     title: 'Notification',
            //     ontap: () {}),
            listTile(
                icon: Icons.favorite_border_outlined,
                title: 'WishList',
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WishList(),
                    ),
                  );
                }),
            listTile(
                icon: Icons.summarize, title: 'Raise a Complain', ontap: () { Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RaiseAComplain(),
              ),
            );}),
            // listTile(
            //     icon: Icons.messenger_outline, title: 'FAQs', ontap: () {}),
          ],
        ),
      ),
    );
  }
}
