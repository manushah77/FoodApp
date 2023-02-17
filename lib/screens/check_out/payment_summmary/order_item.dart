import 'package:flutter/material.dart';
import 'package:food_app_complete/models/review_cart_model.dart';

class OrderItem extends StatefulWidget {
  bool? isTrue;
  final ReviewCartModel reviewCartModel;
  OrderItem({Key? key, this.isTrue, required this.reviewCartModel}) : super(key: key);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 70,
        width: 70,
        child: Image.network(
            '${widget.reviewCartModel.cartImage}'),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Text(widget.isTrue == false ? ' Food Name' : 'Cart Name'),
          Text(
            '${widget.reviewCartModel.cartName}',
            style: TextStyle(
              color: Colors.grey[900],
            ),
          ),
          Text(
            '${widget.reviewCartModel.cartUnit}',
            style: TextStyle(
              color: Colors.grey[900],
            ),
          ),
          Text(
            '${widget.reviewCartModel.cartPrice}\$',
          )
        ],
      ),
      subtitle: Text('${widget.reviewCartModel.cartQuantity}'),
    );
  }
}
