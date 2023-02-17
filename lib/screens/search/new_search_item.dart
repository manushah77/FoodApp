import 'package:flutter/material.dart';

class NewSearchItem extends StatelessWidget {
  bool? isbool = false;
  String? productImage;
  String? productName;
  int? productPrice;


   NewSearchItem({
     this.isbool,
     this.productName,
     this.productImage,
     this.productPrice,

});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 70,
            child: Center(
              child: Image.network(
                '${productImage}',
              ),
            ),
          ),
        ),
        Expanded(
            child: Container(
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${productName}',
                    style:
                    TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    '${productPrice}\$/Gram',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ))
      ],
    );
  }
}
