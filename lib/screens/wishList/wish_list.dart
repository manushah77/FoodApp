import 'package:flutter/material.dart';
import 'package:food_app_complete/constant/colors.dart';
import 'package:food_app_complete/models/product_model.dart';
import 'package:food_app_complete/models/review_cart_model.dart';
import 'package:food_app_complete/providers/review_cart_provider.dart';
import 'package:food_app_complete/providers/wish_list_provider.dart';
import 'package:food_app_complete/screens/search/search_item.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class WishList extends StatefulWidget {
  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  WishListProvider? wishListProvider;

  @override
  Widget build(BuildContext context) {
    wishListProvider = Provider.of(context);
    wishListProvider!.getWishListDate();
    return Scaffold(
      appBar: AppBar(
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
          'Wish List',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
      body: wishListProvider!.getWishList.isEmpty
          ? Center(
              child: Text(
                'No Data',
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 16,
                ),
              ),
            )
          : ListView.builder(
              itemCount: wishListProvider!.getWishList.length,
              itemBuilder: (context, index) {
                ProductModel data = wishListProvider!.getWishList[index];
                return Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    SearchItem(
                      isbool: true,
                      productImage: data.ProductImage,
                      productPrice: data.ProductPrice,
                      productName: data.ProductName,
                      productId: data.ProductId,
                      productUnit: '${data.productUnit}',
                      productQuantity: data.ProductQuantity,
                      onDelete: () {
                        showAlertDialog(context, data);
                      },
                    ),
                  ],
                );
              }),
    );
  }

  //alert dialog

  showAlertDialog(BuildContext context, ProductModel delete) {
    // set up the buttons
    QuickAlert.show(
        context: context,
        type: QuickAlertType.confirm,
        text: 'Are you Sure to Delete!',
        onCancelBtnTap: () {
          Navigator.pop(context);
        },
        showCancelBtn: true,
        confirmBtnText: 'Yes',
        confirmBtnColor: primaryColor,

        onConfirmBtnTap: () {
          wishListProvider!.deleteWish(delete.ProductId);
          Navigator.pop(context);
        });

  }

}
