import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {

  final String title;
  final Function onTap;
  final TextStyle txtStyle;

  CustomText({
    this.title,
    this.onTap,
    this.txtStyle
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(title, style: txtStyle ),
    );
  }
}