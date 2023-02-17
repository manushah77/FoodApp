import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app_complete/models/product_model.dart';

class WishListProvider with ChangeNotifier {
  void addWishListCartData({
    String? wishListId,
    String? wishListName,
    String? wishListImage,
    int? wishListQuantity,
    int? wishListPrice,
  }) async {
    await FirebaseFirestore.instance
        .collection('WishList')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('YourWishList')
        .doc(wishListId)
        .set({
      'wishListName': wishListName,
      'wishListImage': wishListImage,
      'wishListId': wishListId,
      'wishListPrice': wishListPrice,
      'wishListQuantity': wishListQuantity,
      'wishList': true,
    });
  }

  List<ProductModel> wishList = [];

  getWishListDate() async {
    List<ProductModel> newList = [];
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('WishList')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('YourWishList')
        .get();
    snapshot.docs.forEach(
      (element) {
        ProductModel productModel = ProductModel(
          ProductImage: element.get('wishListImage'),
          ProductName: element.get('wishListName'),
          ProductPrice: element.get('wishListPrice'),
          ProductId: element.get('wishListId'),
          ProductQuantity: element.get('wishListQuantity'), productUnit: [],
        );
        newList.add(productModel);
      },
    );
    wishList = newList;
    notifyListeners();
  }

  List<ProductModel> get getWishList {
    return wishList;
  }



  //delete//

  deleteWish (wishListId) {
    FirebaseFirestore.instance
        .collection('WishList')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('YourWishList').doc(wishListId).delete();
  }



}
