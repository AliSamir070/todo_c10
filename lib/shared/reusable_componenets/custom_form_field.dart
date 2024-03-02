import 'package:flutter/material.dart';

typedef fieldValidation = String? Function(String?)? ;
class CustomFormField extends StatelessWidget {
  String label;
  TextInputType keyboard;
  bool obscureText;
  Widget? suffixIcon;
  fieldValidation validator;
  TextEditingController controller;
  int maxLInes;
  CustomFormField({Key? key,
    this.maxLInes = 1,
    this.validator,required this.controller,this.suffixIcon,this.obscureText = false,required this.label,required this.keyboard}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      keyboardType: keyboard,
      obscureText: obscureText,
      obscuringCharacter: "#",
      controller: controller,
      maxLines: maxLInes,
      style: TextStyle(
        color: Colors.black,
        fontSize: 16
      ),
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: suffixIcon
      ),
    );
  }
}
