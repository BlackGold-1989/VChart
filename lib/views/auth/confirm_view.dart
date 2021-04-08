import 'dart:async';

import 'package:app/cstmuis/pincode_ui.dart';
import 'package:app/models/user_model.dart';
import 'package:app/resources/dimen.dart';
import 'package:app/resources/text_styles.dart';
import 'package:app/resources/widget_styles.dart';
import 'package:app/services/loader_service.dart';
import 'package:app/services/navigation_service.dart';
import 'package:app/utils/util_app.dart';
import 'package:app/utils/utils_constants.dart';
import 'package:app/views/main_views/home_view.dart';
import 'package:app/views/main_views/userinfo_register_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


class ConfirmPage extends StatefulWidget {
  ConfirmPage({this.fbApp});
  final FirebaseApp fbApp;

  @override
  _ConfirmPageState createState() => _ConfirmPageState();
}

class _ConfirmPageState extends State<ConfirmPage> {
  UserModel userModel = new UserModel();

  FirebaseAuth mAuth = FirebaseAuth.instance;
  DatabaseReference userRef;

  TextEditingController txt_sms_code = TextEditingController();

  String verificationId = '', pinCode = '', phone = '';
  bool verifyComplete = false;

  Future onSendVerification() async {
    if(!verifyComplete){
      await mAuth.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (AuthCredential credential) {
          verifyCompletedAutomatically(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          showToast(appLocale.translate('enterValidPhone'));
          Navigator.of(context).pop();
        },
        codeSent: (String _verificationId, [int resendToken]) {
          verificationId = _verificationId;
        },
        timeout: Duration(seconds: 60), codeAutoRetrievalTimeout: (String verificationId) {
          failedPhoneVerification(appLocale.translate('timeout'));
        },
      );
    }
  }

  void verifyCompletedAutomatically(AuthCredential credential) async {
    await mAuth.signInWithCredential(credential).then((result) => {
      if(result.user.uid != null){
        completePhoneVerification(),
      }
    }).catchError((error) {
      failedPhoneVerification(appLocale.translate('errorPhoneVerify'));
    });
  }

  void verifyCompletedByPin() async {
    if(pinCode.length < 6){
      showToast(appLocale.translate('enterAllPinCode'));
    }else{
      AuthCredential phoneAuthCredential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: pinCode);
      await mAuth.signInWithCredential(phoneAuthCredential).then((result) => {
        if(result.user.uid != null){
          completePhoneVerification(),
        }
      }).catchError((error) {
        failedPhoneVerification(appLocale.translate('errorPhoneVerify'));
      });
    }
  }

  void completePhoneVerification(){
    verifyComplete = true;
    currentUser.userId = mAuth.currentUser.uid;

    if(signinStatus == appLocale.translate('signIn')){
      fetchUserModel();
    }else{
      currentUser.userId = currentUser.userId;
      currentUser.phoneNumber = phoneCountryCode + phoneNumber;
      NavigationService().navigateToScreen(context, UserInfoRegister(fbApp: widget.fbApp, registerIndex: REG_NAME,), );
    }
  }

  void failedPhoneVerification(String msg){
    showToast(msg);
  }

  Future<void> fetchUserModel() async {
    await userRef.child(currentUser.userId).once().then((DataSnapshot snapshot) {
      if(snapshot.value != null){
        currentUser = UserModel.fromJson(snapshot.value);
        currentUser.phoneNumber = phoneCountryCode + phoneNumber;
        NavigationService().navigateToScreen(context, HomePage(fbApp: widget.fbApp,), replace: true);
      }
      else{
        NavigationService().navigateToScreen(context, UserInfoRegister(fbApp: widget.fbApp, registerIndex: REG_NAME,), );
      }
    }).catchError((error) {
      NavigationService().navigateToScreen(context, UserInfoRegister(fbApp: widget.fbApp, registerIndex: REG_NAME,), );
    });
  }

  @override
  void initState() {
    super.initState();
    userRef = FirebaseDatabase.instance.reference().child(TB_USER);
    phone = phoneCountryCode + phoneNumber;

    onSendVerification();
  }

  @override
  Widget build(BuildContext context) {
    offsetXLg = MediaQuery.of(context).size.width * 0.06;
    return Scaffold(
      appBar: statusGradient(context),
      resizeToAvoidBottomInset: true,
      body: Container(
        width: double.infinity, height: double.infinity,
        decoration: mainGradient(),
        child: Padding(
          padding: EdgeInsets.only(left: offsetXLg, top: 56.0, right: offsetXLg),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                      onTap: (){
                        onClickBack();
                      },
                      child: smallIcon(Icons.arrow_back_ios_rounded)
                  ),
                  Spacer(),
                ],
              ),

              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 24, top: 48),
                    child: Text(
                      appLocale.translate('myCodeIs'),
                      textAlign: TextAlign.start,
                      style: gilroyStyleBold().copyWith(fontSize: 28.0),
                    ),
                  ),
                  Spacer(),
                ],
              ),

              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 24, top: 12),
                    child: Text(
                      phoneNumber_otp_hint.substring(1),
                      textAlign: TextAlign.start,
                      style: gilroyStyleRegular().copyWith(fontSize: 18.0),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 24, top: 8),
                    child: InkWell(
                      onTap: (){
                        onResendCode();
                      },
                      child: Text(
                        appLocale.translate('reSend'),
                        textAlign: TextAlign.start,
                        style: gilroyStyleRegular().copyWith(fontSize: 24.0),
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),

              Container(
                margin: EdgeInsets.only(top: 12.0),
                child: PinCodeUI(
                  changeCallback: (pin){},
                  completeCallback: (pin){
                    onPinCompleted(pin);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onClickBack() {
    Navigator.of(context).pop();
  }

  void onResendCode() {
    verifyCompletedByPin();
  }

  void onPinCompleted(String pin) {
    pinCode = pin;
    verifyCompletedByPin();
  }
}
