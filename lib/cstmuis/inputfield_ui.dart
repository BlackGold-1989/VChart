import 'package:app/resources/colors.dart';
import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {

  final TextEditingController controller;
  TextInputType keyboardType;
  final TextStyle txtStyle;
  final TextStyle hintStyle;
  final TextStyle labelStyle;
  final String label;
  final String hint;
  final Icon image;
  final bool readOnly;
  final int maxLength;
  final IconData suffixIcon;
  final FocusNode focusNode;
  final Widget countryWidget;
  final Function onTap;

  CustomInput(
      {this.controller,
      this.label,
      this.image,
      this.txtStyle,
      this.hintStyle,
      this.labelStyle,
      this.readOnly = false,
      this.keyboardType,
      this.maxLength,
      this.hint,
      this.suffixIcon,
      this.focusNode,
      this.countryWidget,
      this.onTap,
    });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: onTap,
      controller: controller,
      readOnly: readOnly,
      keyboardType: keyboardType,
      maxLength: maxLength,
      focusNode: focusNode,
      style: txtStyle,
      minLines: 1,
      cursorColor: kWhiteColor,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(16),
        hintText: hint,
        hintStyle: hintStyle,
        labelText: label,
        labelStyle: labelStyle,
        prefixIcon: countryWidget,
        suffixIcon: Icon(
          suffixIcon,
          size: 28,
          color: kWhiteColor,
        ),
        enabledBorder: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(12.0),
          borderSide: new BorderSide(color: kTransparentColor),
        ),
        focusedBorder: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(12.0),
          borderSide: new BorderSide(color: kTransparentColor),
        ),
        icon: image,
      ),
    );
  }
}
