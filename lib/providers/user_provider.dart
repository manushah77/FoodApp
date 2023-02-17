import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:food_app_complete/models/user_model.dart';

class UserProvider with ChangeNotifier {
  void addsUerData({
    User? currentUser,
    String? userName,
    String? userEmail,
    String? userImage,
    String? userId,
  }) async {
    await FirebaseFirestore.instance
        .collection('userData')
        .doc(currentUser!.uid)
        .set({
      'userName': userName,
      'userEmail': userEmail,
      'userImage': userImage,
      'userId': currentUser.uid,
    });
  }

  //get user data//

  UserModel? currentData;

  void getUserData() async {
    UserModel userModel;
    var value = await FirebaseFirestore.instance
        .collection('userData')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (value.exists) {
      userModel = UserModel(
        userName: value.get('userName'),
        userImage: value.get('userImage'),
        userEmail: value.get('userEmail'),
        userUid: value.get('userId'),
      );
      currentData = userModel;
      notifyListeners();
    }
  }
  UserModel get currentUserData {
    return currentData!;
  }
}
