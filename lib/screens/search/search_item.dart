import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app_complete/constant/colors.dart';
import 'package:food_app_complete/providers/review_cart_provider.dart';
import 'package:food_app_complete/widgets/count.dart';
import 'package:provider/provider.dart';

class SearchItem extends StatefulWidget {
  bool? isbool = false;
  String? productImage;
  String? productName;
  int? productPrice;
  String? productId;
  int? productQuantity;
  Function? onDelete;
  bool? wishList = false;
  var productUnit;

  SearchItem({
    this.isbool,
    this.productUnit,
    this.wishList,
    this.productName,
    this.productImage,
    this.productPrice,
    this.productId,
    this.onDelete,
    this.productQuantity,
  });

  @override
  State<SearchItem> createState() => _SearchItemState();
}

class _SearchItemState extends State<SearchItem> {
 late ReviewCartProvider reviewCartProvider;

 int count = 0;
 void getCount() {
    setState(() {
      count = widget.productQuantity!;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getCount();
  }

  @override
  Widget build(BuildContext context) {
    reviewCartProvider = Provider.of(context);
    reviewCartProvider.getReviewCartData();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  height: 100,
                  child: Center(
                    child: Image.network(
                      '${widget.productImage}',
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 100,
                  child: Column(
                    mainAxisAlignment: widget.isbool == false
                        ? MainAxisAlignment.spaceAround
                        : MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${widget.productName}',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '${widget.productPrice}\$',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      // widget.isbool == false
                      //     ? InkWell(
                      //         onTap: () {
                      //           // _productweightBottomSheet(context);
                      //         },
                      //         child: Container(
                      //           height: 35,
                      //           margin: EdgeInsets.only(right: 15),
                      //           padding: EdgeInsets.symmetric(horizontal: 10),
                      //           decoration: BoxDecoration(
                      //               borderRadius: BorderRadius.circular(30),
                      //               border: Border.all(color: Colors.grey)),
                      //           child: Row(
                      //             children: [
                      //               Expanded(
                      //                 child: Text(
                      //                   '50 Gram',
                      //                   style: TextStyle(
                      //                       color: Colors.grey, fontSize: 14),
                      //                 ),
                      //               ),
                      //               Center(
                      //                 child: Icon(
                      //                   Icons.arrow_drop_down,
                      //                   size: 20,
                      //                 ),
                      //               )
                      //             ],
                      //           ),
                      //         ),
                      //       )
                      //     : Text('${widget.productUnit}'),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: widget.isbool == false
                      ? EdgeInsets.symmetric(horizontal: 10, vertical: 20)
                      : EdgeInsets.only(
                          left: 15,
                          right: 15,
                          top: 5,
                        ),
                  height: 85,
                  child: widget.isbool == true
                      ? Column(
                          children: [
                            InkWell(
                              onTap: () {
                                widget.onDelete!();
                              },
                              child: Icon(
                                Icons.delete,
                                color: Colors.red,
                                size: 30,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 25,
                              width: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        if (count == 1) {
                                          Fluttertoast.showToast(
                                              msg:
                                                  'You are reach at your limit');
                                        } else {
                                          setState(() {
                                            count--;
                                          });
                                          reviewCartProvider.updateCartData(
                                            cartQuantity: count,
                                            cartPrice: widget.productPrice,
                                            cartName: widget.productName,
                                            cartId: widget.productId,
                                            cartImage: widget.productImage,
                                          );
                                        }
                                      },
                                      child: Icon(
                                        Icons.remove,
                                        size: 20,
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${count}",
                                      style: TextStyle(
                                        color: primaryColor,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        if (count < 5) {
                                          setState(() {
                                            count++;
                                          });
                                          reviewCartProvider.updateCartData(
                                            cartQuantity: count,
                                            cartPrice: widget.productPrice,
                                            cartName: widget.productName,
                                            cartId: widget.productId,
                                            cartImage: widget.productImage,
                                          );
                                        }
                                      },
                                      child: Icon(
                                        Icons.add,
                                        size: 20,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            // Icon(
                            //   Icons.delete,
                            //   color: Colors.red,
                            //   size: 30,
                            // ),
                            // SizedBox(
                            //   height: 5,
                            // ),
                            Container(
                              height: 25,
                              width: 55,
                              child: Counter(
                                productName: widget.productName,
                                productImage: widget.productImage,
                                productPrice: widget.productPrice,
                                productId: widget.productId,
                                // productQuantity: widget.productQuantity.toString(),
                                // productUnit: widget.productUnit,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ],
          ),
        ),
        widget.isbool == false
            ? Container()
            : Divider(
                height: 1,
                color: Colors.black45,
              )
      ],
    );
  }

  // void _productweightBottomSheet(context) {
  //   showModalBottomSheet(
  //       context: context,
  //       builder: (BuildContext bc) {
  //         return Container(
  //           child: new Wrap(
  //             children: <Widget>[
  //               new ListTile(title: new Text('500 Gram'), onTap: () => {}),
  //               new ListTile(title: new Text('1 kg'), onTap: () => {}),
  //               new ListTile(
  //                 title: new Text('2 kg'),
  //                 onTap: () => {},
  //               ),
  //               new ListTile(
  //                 title: new Text('3 kg'),
  //                 onTap: () => {},
  //               ),
  //               new ListTile(
  //                 title: new Text('4 kg'),
  //                 onTap: () => {},
  //               ),
  //               new ListTile(
  //                 title: new Text('5 kg'),
  //                 onTap: () => {},
  //               ),
  //             ],
  //           ),
  //         );
  //       });
  // }
}
