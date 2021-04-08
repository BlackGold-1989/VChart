import 'package:app/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Gilroy font bold style
TextStyle gilroyStyleBold(){
  return TextStyle(
    fontSize: 24,
    color: kWhiteColor,
    fontWeight: FontWeight.w500,
    fontFamily: 'Gilroy',
  );
}

// Gilroy font bold style
TextStyle gilroyStyleMedium(){
  return TextStyle(
    fontSize: 24,
    color: kWhiteColor,
    fontWeight: FontWeight.w300,
    fontFamily: 'Gilroy',
  );
}

// Gilroy font bold style
TextStyle gilroyStyleRegular(){
  return TextStyle(
    fontSize: 24,
    color: kWhiteColor,
    fontWeight: FontWeight.w200,
    fontFamily: 'Gilroy',
  );
}

// hind guntur bold text style
TextStyle hindGunturNormal(){
  return GoogleFonts.hindGuntur().copyWith(
      fontSize: 24.0,
      color: Colors.white,
      fontWeight: FontWeight.w100
  );
}