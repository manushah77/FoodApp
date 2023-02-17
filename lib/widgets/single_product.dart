import 'package:flutter/material.dart';
import 'package:food_app_complete/constant/colors.dart';
import 'package:food_app_complete/models/product_model.dart';
import 'package:food_app_complete/widgets/count.dart';
import 'package:food_app_complete/widgets/product_unit.dart';

class SingleProduct extends StatefulWidget {
  final String productImage;
  final String productName;
  final String? productId;
  final int productPrice;
  final Function ontap;
  final ProductModel productUnit;

  SingleProduct(
      {Key? key,
      required this.productImage,
      required this.productName,
      this.productId,
      required this.productUnit,
      required this.ontap,
      required this.productPrice})
      : super(key: key);

  @override
  State<SingleProduct> createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  var unitData;
  var firstValue;

  @override
  Widget build(BuildContext context) {
    widget.productUnit.productUnit!.firstWhere((element) {
      setState(() {
        firstValue = element;
      });
      return true;
    });
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5, vertical: 7),
            height: 230,
            width: 160,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(1, 3)),
                ]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5,
                ),
                Expanded(
                  flex: 2,
                  child: InkWell(
                    onTap: () {
                      widget.ontap();
                    },
                    child: widget.productImage.isEmpty
                        ? Container(
                            height: 130,
                            width: 140,
                            child: Image.asset(
                              'assets/images/oop.png',
                              height: 90,
                              width: 120,
                            ),
                          )
                        : Container(
                            height: 130,
                            width: 140,
                            child: Image.network(
                              widget.productImage,
                              height: 90,
                              width: 120,
                            ),
                          ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.productName,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            // '${widget.productPrice}\$/ ${unitData == null ? firstValue : unitData}',
                            '${widget.productPrice}\$/ ${unitData == null ? firstValue : unitData}',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.grey),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: ProductUnit(
                                  onTap: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext bc) {
                                          return Container(
                                            child: new Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: widget
                                                  .productUnit.productUnit!
                                                  .map<Widget>(
                                                (data) {
                                                  return Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal:
                                                                    10.0,
                                                                vertical: 10),
                                                        child: InkWell(
                                                          onTap: () async {
                                                            setState(() {
                                                              unitData = data;
                                                            });
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: Text(
                                                            data,
                                                            style: TextStyle(
                                                              color:
                                                                  primaryColor,
                                                              fontSize: 18,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  );
                                                },
                                              ).toList(),
                                            ),
                                          );
                                        });
                                    ;
                                  },
                                  title:
                                      unitData == null ? firstValue : unitData,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                flex: 2,
                                child: Counter(
                                  productName: widget.productName,
                                  productImage: widget.productImage,
                                  productPrice: widget.productPrice,
                                  productId: widget.productId,
                                  productUnit:
                                      unitData == null ? firstValue : unitData,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
