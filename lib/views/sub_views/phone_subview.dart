import 'package:app/cstmuis/button_ui.dart';
import 'package:app/resources/colors.dart';
import 'package:app/resources/text_styles.dart';
import 'package:app/utils/util_app.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class PhoneEntryView extends StatelessWidget {
  PhoneEntryView(this.countryCode, this.txtPhone, this.changeCallback, this.sendCodeCallback);
  Function sendCodeCallback;
  Function changeCallback;
  String txtPhone;
  String countryCode;

  TextEditingController _txt_phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _txt_phone.text = txtPhone;

    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 48.0),
            height: 36,
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 8.0),
                  child: CountryCodePicker(
                    onChanged: (c) => onChangeCountryCode(c),
                    initialSelection: '+1',
                    favorite: ['+1'],
                    showFlag: false,
                    showDropDownButton: true,
                    showCountryOnly: false,
                    alignLeft: false,
                    textStyle: gilroyStyleRegular().copyWith(fontSize: 16.0),
                  ),
                ),

                Container(
                  width: 1, height: 18, color: kWhiteColor,
                ),

                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 19.0),
                    child: TextFormField(
                      controller: _txt_phone,
                      style: gilroyStyleRegular().copyWith(color: kWhiteColor, fontSize: 16.0),
                      decoration: InputDecoration(
                        hintText: appLocale.translate('phoneNumber'),
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
                      onChanged: (val){
                        onChangedPhoneNumber(val);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),

          Container(
            margin: EdgeInsets.only(left: 2.0, right: 2.0),
            width: double.infinity, height: 1, color: kWhiteColor,
          ),

          Container(
            margin: EdgeInsets.only(top: 36),
            child: Text(
                appLocale.translate('willSendText'),
                style: gilroyStyleRegular().copyWith(color: kWhiteDisabledColor, fontSize: 14)
            ),
          ),

          if(signinStatus == appLocale.translate('signUp'))
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

          Container(
            width: 280,
            margin: EdgeInsets.only(top: 56.0),
            height: 44.0,
            child: CustomButton(
              enableLeading: false,
              title: appLocale.translate('sendCode'),
              setIconColor: false,
              buttonColor: kWhiteColor,
              txtStyle: gilroyStyleBold().copyWith(fontSize: 14.0, color: kTextMainColor),
              onTap: (){
                onSendCode();
              },
            ),
          ),
        ],
      ),
    );
  }

  onChangeCountryCode(CountryCode c) {
    countryCode = c.toString();
    changeCallback(countryCode, _txt_phone.text);
  }

  void onChangedPhoneNumber(String val) {
    changeCallback(countryCode, _txt_phone.text);
  }

  onSendCode(){
    sendCodeCallback();
  }
}
