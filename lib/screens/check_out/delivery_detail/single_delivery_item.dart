import 'package:flutter/material.dart';
import 'package:food_app_complete/constant/colors.dart';

class SingleDeliveryItem extends StatefulWidget {
  final String? title;
  final String? adress;
  final String? number;
  final String? adressType;

  SingleDeliveryItem(
      {K, this.title, this.adress, this.number, this.adressType});

  @override
  State<SingleDeliveryItem> createState() => _SingleDeliveryItemState();
}

class _SingleDeliveryItemState extends State<SingleDeliveryItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            radius: 8,
            backgroundColor: primaryColor,
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${widget.title}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),
              ),
              Container(
                height: 20,
                width: 60,
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    '${widget.adressType}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ],
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${widget.adress}'),
              SizedBox(
                height: 10,
              ),
              Text('${widget.number}'),

            ],
          ),

        ),
        Divider(
          height: 35,
        )
      ],
    );
  }
}
