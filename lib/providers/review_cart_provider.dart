import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_app_complete/models/review_cart_model.dart';

FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;

class ReviewCartProvider with ChangeNotifier {
  void addsCartData({
    String? cartName,
    String? cartImage,
    String? cartId,
    int? cartQuantity,
    int? cartPrice,
    var cartUnit,

  }) async {
    await FirebaseFirestore.instance
        .collection('ReviewCart')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('YourReviewCart')
        .doc(cartId)
        .set({
      'cartName': cartName,
      'cartImage': cartImage,
      'cartId': cartId,
      'cartPrice': cartPrice,
      'cartQuantity': cartQuantity,
      'isAdd' : true,
      'cartUnit' : cartUnit,

    });
  }

  //update

  void updateCartData({
    String? cartName,
    String? cartImage,
    String? cartId,
    int? cartQuantity,
    int? cartPrice,
  }) async {
    await FirebaseFirestore.instance
        .collection('ReviewCart')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('YourReviewCart')
        .doc(cartId)
        .update({
      'cartName': cartName,
      'cartImage': cartImage,
      'cartId': cartId,
      'cartPrice': cartPrice,
      'cartQuantity': cartQuantity,
      'isAdd' : true,

    });
  }

  List<ReviewCartModel> reviewCartDetailList = [];

  void getReviewCartData() async {
    List<ReviewCartModel> newList = [];

    QuerySnapshot reviewCart = await _firebaseFirestore
        .collection('ReviewCart')
        .doc(auth.currentUser!.uid)
        .collection('YourReviewCart')
        .get();
    reviewCart.docs.forEach((element) {
      ReviewCartModel reviewCartModel = ReviewCartModel(
        cartId: element.get('cartId'),
        cartName: element.get('cartName'),
        cartImage: element.get('cartImage'),
        cartPrice: element.get('cartPrice'),
        cartQuantity: element.get('cartQuantity'),
        cartUnit: element.get('cartUnit'),
      );
      newList.add(reviewCartModel);
    });
    reviewCartDetailList = newList;
    notifyListeners();
  }

  List<ReviewCartModel> get getReviewCartDataList {
    return reviewCartDetailList;
  }


  //total price
  getTotalPrice () {
    double total = 0.0;
    reviewCartDetailList.forEach((element) {
      total += element.cartPrice * element.cartQuantity;
    });
    return total;
  }

  //delete from cart//

  reviewCartDataDelete(cartId) {
    _firebaseFirestore.collection('ReviewCart')
        .doc(auth.currentUser!.uid)
        .collection('YourReviewCart').doc(cartId)
        .delete();
    notifyListeners();
  }

}
