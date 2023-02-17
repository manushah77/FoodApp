import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app_complete/constant/colors.dart';
import 'package:food_app_complete/models/product_model.dart';
import 'package:food_app_complete/screens/search/new_search_item.dart';
import 'package:food_app_complete/screens/search/search_item.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class Search extends StatefulWidget {
  List<ProductModel> search;

  Search({required this.search});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String query = '';

  searchItem(String query) {
    List<ProductModel> searchFood = widget.search
        .where((element) => element.ProductName.toLowerCase().contains(query))
        .toList();
    return searchFood;
  }

  @override
  Widget build(BuildContext context) {
    List<ProductModel> _search = searchItem(query);

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
        elevation: 0,
        backgroundColor: primaryColor,
        title: Text('Search'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Search Item'),
          ),
          Container(
            height: 52,
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              onChanged: (value) {
                setState(() {
                  query = value;
                });
              },
              cursorColor: primaryColor,
              decoration: InputDecoration(
                iconColor: primaryColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                fillColor: Colors.grey.withOpacity(0.4),
                filled: true,
                hintText: 'Search',
                suffixIcon: Icon(
                  Icons.search,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Column(
            children: _search.map((e) {
              return NewSearchItem(
                isbool: true,
                productImage: e.ProductImage,
                productPrice: e.ProductPrice,
                productName: e.ProductName,

                // onDelete: () {
                //   showAlertDialog(context, e);
                // },
              );
            }).toList(),
          ),
          // Column(
          //   children: _search.map((e) {
          //     return SearchItem(
          //       isbool: true,
          //       productImage: e.ProductImage,
          //       productPrice: e.ProductPrice,
          //       productName: e.ProductName,
          //       productId: e.ProductId,
          //       productUnit: e.productUnit,
          //       productQuantity: e.ProductQuantity,
          //       onDelete: () {
          //         showAlertDialog(context, e);
          //       },
          //     );
          //   }).toList(),
          // )
        ],
      ),
      // body: ListView(
      //   scrollDirection: Axis.vertical,
      //   children: [
      //     ListTile(
      //       title: Text('Search Item'),
      //     ),
      //     Container(
      //       height: 52,
      //       margin: EdgeInsets.symmetric(horizontal: 20),
      //       child: TextFormField(
      //         onChanged: (value){
      //           setState(() {
      //             query = value;
      //           });
      //         },
      //         cursorColor: primaryColor,
      //         decoration: InputDecoration(
      //           iconColor: primaryColor,
      //           border: OutlineInputBorder(
      //             borderRadius: BorderRadius.circular(12),
      //             borderSide: BorderSide.none,
      //           ),
      //           fillColor: Colors.grey.withOpacity(0.4),
      //           filled: true,
      //           hintText: 'Search',
      //           suffixIcon: Icon(
      //             Icons.search,
      //           ),
      //         ),
      //       ),
      //     ),
      //     SizedBox(
      //       height: 15,
      //     ),
      //     Column(
      //       children: _search.map((e) {
      //         return SearchItem(
      //           isbool: true,
      //           productImage: e.ProductImage,
      //           productPrice: e.ProductPrice,
      //           productName: e.ProductName,
      //           productId: e.ProductId,
      //           productUnit: e.productUnit,
      //           productQuantity: e.ProductQuantity,
      //           // onDelete: () {
      //           //   showAlertDialog(context, e);
      //           // },
      //         );
      //       }).toList(),
      //     ),
      //   ],
      // ),
    );
  }

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
          Navigator.pop(context);
        });
  }
}
