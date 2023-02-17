import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_app_complete/models/product_model.dart';

class ProductProvider with ChangeNotifier {
  ProductModel? productModel;
  List<ProductModel> searchitems = [];

  productmodel(QueryDocumentSnapshot element) {
    productModel = ProductModel(
      ProductImage: element.get('productImage'),
      ProductName: element.get('productName'),
      ProductPrice: element.get('productPrice'),
      ProductId: element.get('productId'),
      productUnit: element.get('productUnit'),
     );
    searchitems.add(productModel!);
  }

  List<ProductModel> get getAllProductOfSearch {
    return searchitems;
  }

  ///////// Apple Collection data//////////////

  List<ProductModel> appleProduct = [];
  List<ProductModel> newlist = [];

  fetchAppleProduct() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('Applecollection').get();
    snapshot.docs.forEach(
      (element) {
        productmodel(element);
        newlist.add(productModel!);
      },
    );
    appleProduct = newlist;
    notifyListeners();
  }

  List<ProductModel> get appleproductlist {
    return appleProduct;
  }

  ///////// Vegitable Collection data//////////////

  List<ProductModel> vegProduct = [];
  List<ProductModel> newlists = [];

  fetchVegProduct() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('VegetableCollection')
        .get();
    snapshot.docs.forEach(
      (element) {
        productmodel(element);
        newlists.add(productModel!);
      },
    );
    vegProduct = newlists;
    notifyListeners();
  }

  List<ProductModel> get vegproductlist {
    return vegProduct;
  }
}
