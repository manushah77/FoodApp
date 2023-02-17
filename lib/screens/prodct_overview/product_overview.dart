import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app_complete/constant/colors.dart';
import 'package:food_app_complete/providers/wish_list_provider.dart';
import 'package:food_app_complete/screens/review_cart/review_cart.dart';
import 'package:food_app_complete/widgets/count.dart';
import 'package:provider/provider.dart';

enum siginCharacter { fill, outline }

class ProductOverview extends StatefulWidget {
  final String productName;
  final String productId;
  final String productImage;
  final int productPrice;
  final int productQuantity;

  ProductOverview({
    required this.productName,
    required this.productPrice,
    required this.productId,
    required this.productQuantity,
    required this.productImage,
  });

  @override
  State<ProductOverview> createState() => _ProductOverviewState();
}

class _ProductOverviewState extends State<ProductOverview> {
  siginCharacter character = siginCharacter.fill;

  Widget bottomNavBar({
    required Color iconColor,
    required Color backgroud,
    required Color color,
    required String title,
    required IconData icon,
    required Function onTap,
  }) {
    return Expanded(
        child: GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: EdgeInsets.all(18),
        color: backgroud,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20,
              color: iconColor,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              title,
              style: TextStyle(color: color),
            )
          ],
        ),
      ),
    ));
  }

  bool wishListBool = false;

  getWishListBool() {
    FirebaseFirestore.instance
        .collection('WishList')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('YourWishList')
        .doc(widget.productId)
        .get()
        .then(
          (value) => {
            if (this.mounted)
              {
                if (value.exists)
                  {
                    setState(() {
                      wishListBool = value.get('wishList');
                    })
                  }
              }
          },
        );
  }

  @override
  Widget build(BuildContext context) {
    WishListProvider wishListProvider = Provider.of(context);
    getWishListBool();
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Row(
        children: [
          bottomNavBar(
            iconColor: Colors.white,
            backgroud: Colors.black,
            color: Colors.white,
            title: wishListBool == false
                ? 'Add to Wish List'
                : 'Added to Wish List',
            icon: wishListBool == false
                ? Icons.favorite_border_outlined
                : Icons.favorite,
            onTap: () {
              setState(() {
                wishListBool = !wishListBool;
              });
              if (wishListBool == true) {
                wishListProvider.addWishListCartData(
                  wishListId: widget.productId,
                  wishListImage: widget.productImage,
                  wishListName: widget.productName,
                  wishListPrice: widget.productPrice,
                  wishListQuantity: 1,
                );
              } else {
                wishListProvider.deleteWish(widget.productId);
              }
            },
          ),
          bottomNavBar(
              iconColor: Colors.white,
              backgroud: primaryColor,
              color: Colors.white,
              title: 'Go to Cart',
              icon: Icons.add_shopping_cart_outlined,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReviewCart(),
                  ),
                );
              }),
        ],
      ),
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: Text(
          'Product OverView',
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      '${widget.productName}',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    subtitle: Text('\$${widget.productPrice}'),
                  ),
                  Container(
                    height: 300,
                    padding: EdgeInsets.all(40),
                    child: Image.network('${widget.productImage}'),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    child: Text(
                      'Available Options',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 3,
                              backgroundColor: Colors.green[700],
                            ),
                            Radio(
                              value: siginCharacter.fill,
                              activeColor: Colors.green[700],
                              onChanged: (value) {
                                setState(() {
                                  character = value!;
                                });
                              },
                              groupValue: character,
                            ),
                          ],
                        ),
                        Text('\$${widget.productPrice}'),
                        Container(
                          height: 30,
                          width: 70,
                          child: Counter(
                            productName: widget.productName,
                            productImage: widget.productImage,
                            productPrice: widget.productPrice,
                            productId: widget.productId,
                            productUnit: '500 gram',
                          ),
                        ),
                        // Container(
                        //   padding: EdgeInsets.symmetric(
                        //       horizontal: 30, vertical: 10),
                        //   decoration: BoxDecoration(
                        //     border: Border.all(color: Colors.grey),
                        //     borderRadius: BorderRadius.circular(30),
                        //   ),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       Icon(
                        //         Icons.add,
                        //         size: 17,
                        //         color: primaryColor,
                        //       ),
                        //       Text(
                        //         'ADD',
                        //         style: TextStyle(color: primaryColor),
                        //       )
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.only(left: 15, right: 15),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About this Product',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'PRODUCT DESCRIPTION: The delicate, floral and sweet Gala Apple has a bright, sweet flavour that makes it delightful in sauces, chutneys and on salads.',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                    ),
                    textAlign: TextAlign.start,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
