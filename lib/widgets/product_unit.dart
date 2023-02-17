import 'package:flutter/material.dart';

class ProductUnit extends StatelessWidget {
final Function onTap;
final String title;
  const ProductUnit({Key? key, required this.onTap, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:(){
        onTap();
      },
      child: Container(
        padding: EdgeInsets.only(left: 5),
        height: 30,
        width: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.grey.withOpacity(0.4),
          ),
        ),
        child: Row(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Text(
                '${title}',
                style: TextStyle(fontSize: 15),
              ),
            ),

            // Center(
            //   child: Icon(
            //     Icons.keyboard_arrow_down,
            //     size: 18,
            //     color: Colors.amber,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
  void _productweightBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(title: new Text('500 Gram'), onTap: () => {}),
                new ListTile(title: new Text('1 kg'), onTap: () => {}),
                new ListTile(
                  title: new Text('2 kg'),
                  onTap: () => {},
                ),
                new ListTile(
                  title: new Text('3 kg'),
                  onTap: () => {},
                ),
                new ListTile(
                  title: new Text('4 kg'),
                  onTap: () => {},
                ),
                new ListTile(
                  title: new Text('5 kg'),
                  onTap: () => {},
                ),
              ],
            ),
          );
        });
  }

}
