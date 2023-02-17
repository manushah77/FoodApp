import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app_complete/constant/colors.dart';
import 'package:food_app_complete/models/review_cart_model.dart';
import 'package:food_app_complete/providers/review_cart_provider.dart';
import 'package:food_app_complete/screens/check_out/delivery_detail/delivery_detail.dart';
import 'package:food_app_complete/screens/search/search_item.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class ReviewCart extends StatefulWidget {
  const ReviewCart({Key? key}) : super(key: key);

  @override
  State<ReviewCart> createState() => _ReviewCartState();
}

class _ReviewCartState extends State<ReviewCart> {
  ReviewCartProvider? reviewCartProvider;

  @override
  Widget build(BuildContext context) {
    reviewCartProvider = Provider.of(context);
    reviewCartProvider!.getReviewCartData();

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        bottomNavigationBar: ListTile(
          title: Text('Total Amont'),
          subtitle: Text(
            '\$ ${reviewCartProvider!.getTotalPrice()}',
            style: TextStyle(
              color: Colors.green[900],
              fontWeight: FontWeight.w600,
            ),
          ),
          trailing: Container(
            width: 160,
            child: MaterialButton(
              onPressed: () {
                reviewCartProvider!.getReviewCartDataList.isEmpty
                    ? Fluttertoast.showToast(msg: 'Cart has no Data')
                    : Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DeliveryDetail(),
                        ),
                      );
              },
              child: Text(
                'Submit',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              color: primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
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
            'Review Cart',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        body: reviewCartProvider!.getReviewCartDataList.isEmpty
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
                itemCount: reviewCartProvider!.getReviewCartDataList.length,
                itemBuilder: (context, index) {
                  ReviewCartModel data =
                      reviewCartProvider!.getReviewCartDataList[index];
                  return Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      SearchItem(
                        isbool: true,
                        wishList: false,
                        productImage: data.cartImage,
                        productPrice: data.cartPrice,
                        productName: data.cartName,
                        productId: data.cartId,
                        productQuantity: data.cartQuantity,
                        productUnit: data.cartUnit,
                        onDelete: () {
                          showAlertDialog(context, data);
                        },
                      ),
                    ],
                  );
                }),
      ),
    );
  }

  //alert Dialog
  showAlertDialog(BuildContext context, ReviewCartModel delete) {
    // set up the AlertDialog
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
          reviewCartProvider!.reviewCartDataDelete(delete.cartId);
          Navigator.pop(context);
        });
    // show the dialog
  }
}
