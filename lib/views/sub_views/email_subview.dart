import 'package:app/cstmuis/button_ui.dart';
import 'package:app/resources/colors.dart';
import 'package:app/resources/text_styles.dart';
import 'package:app/utils/util_app.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class EmailEntryView extends StatelessWidget {
  EmailEntryView(this.txtEmail, this.txtPassword, this.changeCallback, this.emailEntryCallback);
  Function emailEntryCallback;
  Function changeCallback;
  String txtEmail, txtPassword;

  TextEditingController _txt_email = TextEditingController();
  TextEditingController _txt_password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _txt_email.text = txtEmail;
    _txt_password.text = txtPassword;

    return Container(
      margin: EdgeInsets.only(top: 48.0),
      width: double.infinity,
      child: Column(
        children: [
          Container(
            height: 36,
            child: Container(
              margin: EdgeInsets.only(top: 19.0),
              child: TextField(
                controller: _txt_email,
                style: gilroyStyleRegular().copyWith(color: kWhiteColor, fontSize: 16.0),
                keyboardType: TextInputType.emailAddress,
                onChanged: (val) => {
                  onChangeEmailCallback(_txt_email.text, _txt_password.text),
                },
                decoration: InputDecoration(
                  hintText: appLocale.translate('email'),
                  hintStyle: gilroyStyleRegular().copyWith(color: kWhiteColor, fontSize: 16),
                  enabledBorder: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(12.0),
                    borderSide: new BorderSide(color: kTransparentColor),
                  ),
                  focusedBorder: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(12.0),
                    borderSide: new BorderSide(color: kTransparentColor),
                  ),
                ),
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.only(left: 2.0, right: 2.0),
            width: double.infinity, height: 1, color: kWhiteColor,
          ),

          if(signinStatus == appLocale.translate('signIn'))
            Container(
              margin: EdgeInsets.only(top: 24),
              child: Column(
                children: [
                  Container(
                    height: 36,
                    child: Container(
                      margin: EdgeInsets.only(top: 19.0),
                      child: TextField(
                        controller: _txt_password,
                        style: gilroyStyleRegular().copyWith(color: kWhiteColor, fontSize: 16.0),
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        onChanged: (val) => {
                          onChangeEmailCallback(_txt_email.text, _txt_password.text),
                        },
                        decoration: InputDecoration(
                          hintText: appLocale.translate('password'),
                          hintStyle: gilroyStyleRegular().copyWith(color: kWhiteColor, fontSize: 16),
                          enabledBorder: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(12.0),
                            borderSide: new BorderSide(color: kTransparentColor),
                          ),
                          focusedBorder: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(12.0),
                            borderSide: new BorderSide(color: kTransparentColor),
                          ),
                        ),
                      ),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(left: 2.0, right: 2.0),
                    width: double.infinity, height: 1, color: kWhiteColor,
                  ),
                ],
              ),
            ),

          if(signinStatus == appLocale.translate('signUp'))
            Container(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 36),
                    child: Text(
                        appLocale.translate('neverLoseAccess'),
                        style: gilroyStyleRegular().copyWith(color: kWhiteDisabledColor, fontSize: 14)
                    ),
                  ),

                  Container(
                      margin: EdgeInsets.only(top: 36),
                      child: RichText(
                        text: TextSpan(
                          text: appLocale.translate('byContinue1'),
                          style: gilroyStyleRegular().copyWith(fontSize: 12.0, color: kWhiteDisabledColor),
                          children: <TextSpan>[
                            TextSpan(
                              text: appLocale.translate('terms'),
                              style: gilroyStyleRegular().copyWith(fontSize: 14.0, color: kWhiteDisabledColor),
                              recognizer: new TapGestureRecognizer()
                                ..onTap = () => termsOfService(),
                            ),
                            TextSpan(
                              text: appLocale.translate('byContinue2'),
                              style: gilroyStyleRegular().copyWith(fontSize: 12.0, color: kWhiteDisabledColor),
                            ),
                            TextSpan(
                              text: appLocale.translate('privacyPolicy'),
                              style: gilroyStyleRegular().copyWith(fontSize: 14.0, color: kWhiteDisabledColor),
                              recognizer: new TapGestureRecognizer()
                                ..onTap = () => privacyPolicy(),
                            ),
                            TextSpan(
                              text: appLocale.translate('and'),
                              style: gilroyStyleRegular().copyWith(fontSize: 12.0, color: kWhiteDisabledColor),
                            ),
                            TextSpan(
                              text: appLocale.translate('cookiePolicy'),
                              style: gilroyStyleRegular().copyWith(fontSize: 14.0, color: kWhiteDisabledColor),
                              recognizer: new TapGestureRecognizer()
                                ..onTap = () => clickCookie(),
                            ),
                          ],
                        ),
                      )
                  ),
                ],
              ),
            ),

          Container(
            width: 280,
            margin: EdgeInsets.only(top: 56.0),
            height: 44.0,
            child: CustomButton(
              enableLeading: false,
              title: appLocale.translate('next'),
              setIconColor: false,
              buttonColor: kWhiteColor,
              txtStyle: gilroyStyleBold().copyWith(fontSize: 14.0, color: kTextMainColor),
              onTap: (){
                onNext();
              },
            ),
          ),
        ],
      ),
    );
  }

  onChangeEmailCallback(tEmail, tPassword){
    if(signinStatus == appLocale.translate('signUp')){
      _txt_password.text = '';
    }
    changeCallback(tEmail, tPassword);
  }

  onNext(){
    emailEntryCallback();
  }
}
