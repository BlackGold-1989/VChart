import 'package:app/resources/colors.dart';
import 'package:flutter/material.dart';

// back button
Icon smallIcon(IconData icoData){
  return Icon(
    icoData,
    size: 24,
    color: kWhiteColor,
  );
}

// main gradient
BoxDecoration mainGradient(){
  return new BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [kMainColor, kMainMediumColor, kMainColor_light],
      )
  );
}

// appbar without title
AppBar NoTitleBarWidget({Color backgroundColor = Colors.transparent, Brightness brightness = Brightness.light}) {
  return AppBar(
    toolbarHeight: 0,
    elevation: 0,
    backgroundColor: backgroundColor,
    brightness: brightness,
  );
}

// status bar widget with gradient
PreferredSize statusGradient(BuildContext context){
  return PreferredSize(
    child: Container(
      child: AppBar(
        toolbarHeight: 0.0,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [kMainColor, kMainMediumColor, kMainColor_light],
        ),
      ),
    ),
    preferredSize:  Size(MediaQuery.of(context).size.width, 45),
  );
}