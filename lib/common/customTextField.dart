import 'package:flutter/material.dart';
import '../theme.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextAlign titleAlign;
  final Widget icon;
  final bool obscureText;
  final String? Function(String?)? valide;
  final VoidCallback onIconPressed;

  const CustomTextField(
      {super.key,
      required this.title,
      this.valide,
      this.controller,
      this.titleAlign = TextAlign.left,
      required this.icon,
      this.keyboardType,
      this.obscureText = false,
      required this.onIconPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: ThemeColor.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        validator: valide,
        style: TextStyle(
          color: ThemeColor.black,
          decoration: TextDecoration.none,
        ),
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          hintText: title,
          hintStyle: TextStyle(color: ThemeColor.hintFont),
          prefixIcon: GestureDetector(
            onTap: onIconPressed,
            child: icon,
          ),
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
        ),
      ),
    );
  }
}

class CustomTextFieldWithoutIcon extends StatelessWidget {
  final String title;
  final String? Function(String?)? valide;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextAlign titleAlign;
  final bool obscureText;
  final VoidCallback onIconPressed;

  const CustomTextFieldWithoutIcon(
      {super.key,
      required this.title,
      this.controller,
      this.valide,
      this.titleAlign = TextAlign.left,
      this.keyboardType,
      this.obscureText = false,
      required this.onIconPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: ThemeColor.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        maxLines: null,
        expands: true,
        validator: valide,
        style:
            TextStyle(color: ThemeColor.black, decoration: TextDecoration.none),
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        textAlign: TextAlign.start,
        decoration: InputDecoration(
          hintText: title,
          hintStyle: TextStyle(color: ThemeColor.black),
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
        ),
      ),
    );
  }
}
