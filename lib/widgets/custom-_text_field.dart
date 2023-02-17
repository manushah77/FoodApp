import 'package:flutter/material.dart';
class CustomTextField extends StatelessWidget {

 final String label;
 final TextInputType keyboardType;
 final TextEditingController? controller;

  const CustomTextField({Key? key, required this.label, required this.keyboardType, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
        hintText: label,
      ),
    );
  }
}
