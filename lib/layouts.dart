import 'package:flutter/material.dart';

import 'components/constants.dart';

class HeroLogo extends StatelessWidget {
  HeroLogo({required this.height,required this.image, required this.tag});

  final double height;
  final String image, tag;
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag:tag,
      child: Container(
        height: height,
        child: Image.asset(image),
      ),
    );
  }
}

class LayoutTextField extends StatelessWidget {
  LayoutTextField({required this.onChange, required this.hintText, required this.obscureText});

  final Function(String) onChange;
  final String hintText;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      onChanged: onChange,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white),
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        border: kBorder,
        enabledBorder: kEnabledBorder,
        focusedBorder: kFocusedBorder,
      ),
    );
    /*return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.white),
      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      border: kBorder,
      enabledBorder: kEnabledBorder,
      focusedBorder: kFocusedBorder,
    );*/
  }
}
