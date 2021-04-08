import 'package:app/models/user_model.dart';
import 'package:app/resources/colors.dart';
import 'package:app/services/localization_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

String appName = 'CashTime';
AppLocalizations appLocale;

UserModel currentUser;

var phoneCountryCode = '+1';
var phoneNumber = '';
var phoneNumber_otp_hint = '';

var emailStr = '';
var passwordStr = '';

var signinStatus = '';
String profileImgPath = '';

void showToast(String msg){
  Fluttertoast.showToast(
    msg: msg,
    textColor: kWhiteColor,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.black54,
  );
}

void onClickQuote() {

}

void termsOfService(){

}

void privacyPolicy(){

}

void clickCookie() {

}

showAlertDialog(BuildContext context, String title, String content, Function okCallback, Function cancelCallback){
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(content),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
                cancelCallback();
              },
              textColor: Colors.black87,
              child: Text('Cancel'),
            ),
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
                okCallback();
              },
              textColor:Colors.black87,
              child: Text('Ok'),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          elevation: 12,
        );
      }
  );
}
