import 'package:app/resources/colors.dart';
import 'package:app/resources/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DropDownWidget extends StatelessWidget {
  final List<String> spinnerItems;
  final Function onChanged;
  final String selectedVal;
  final FocusNode focusNode;
  final int maxLength;

  DropDownWidget({this.spinnerItems, this.onChanged, this.selectedVal, this.focusNode, this.maxLength});

  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      DropdownButton<String>(
        value: selectedVal,
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 24,
        elevation: 16,
        iconEnabledColor: kWhiteColor,
        focusNode: focusNode,
        style: TextStyle(color: kWhiteColor, fontSize: 14.0,),
        underline: Container(
          height: 1,
          color: kWhiteColor,
        ),
        onChanged: (String data) {
          onChanged(data);
        },
        items: spinnerItems.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value, style: gilroyStyleRegular().copyWith(fontSize: 14.0, color: kYellowColor),),
          );
        }).toList(),
      ),
    ]);
  }
}