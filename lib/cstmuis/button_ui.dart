import 'package:app/resources/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomButton extends StatelessWidget{

  final String title;
  final Color buttonColor;
  final TextStyle txtStyle;
  final String assetPath;
  final bool isSvg;
  final Color iconColor;
  final Function onTap;
  bool setIconColor;
  bool enableLeading;

  CustomButton({
    this.title,
    this.onTap,
    this.txtStyle,
    this.buttonColor = kWhiteColor,
    this.assetPath,
    this.isSvg,
    this.setIconColor = true,
    this.iconColor = kMainColor,
    this.enableLeading = true
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, height: 50.0,
      child: RaisedButton(
        child: Row(
          children: [
            if(enableLeading)
              isSvg == true ? SvgPicture.asset(assetPath, color: iconColor, width: 17,) :
                setIconColor == true ? Image.asset(assetPath, color: iconColor, width: 17,) :
                 Image.asset(assetPath, width: 17,),
            Spacer(),
            Container(
              margin: enableLeading == true ? EdgeInsets.only(right: 18) : EdgeInsets.only(right: 0),
              child: Text(title, style: txtStyle,)),
            Spacer(),
          ],
        ),
        color: buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(color: kWhiteColor, width: 1)
        ),
        focusColor: kYellowColor,
        autofocus: true,
        onPressed: onTap,
      ),
    );
  }
}